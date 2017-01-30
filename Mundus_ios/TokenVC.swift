//
//  TokenVC.swift
//  Mundus_ios
//
//  Created by Team Aldo on 03/01/2017.
//  Copyright (c) 2017 Team Aldo. All rights reserved.
//

import UIKit
import SwiftSpinner
import Aldo

/// ViewController for the screen requesting an authorization token.
class TokenVC: UIViewController, Callback {
    let hostAddress: String = "https://expeditionmundus.herokuapp.com"

    func onResponse(request: String, responseCode: Int, response: NSDictionary) {
        if responseCode == 200 {
            SwiftSpinner.setTitleFont(nil)
            SwiftSpinner.sharedInstance.innerColor = UIColor.green.withAlphaComponent(0.5)
            SwiftSpinner.show(duration: 2.0, title: "Connected", animated: false)
            self.performSegue(withIdentifier: "startMainMenu", sender: nil)
            return
        }

        SwiftSpinner.sharedInstance.outerColor = UIColor.red.withAlphaComponent(0.5)
        SwiftSpinner.show("Failed to connect, tap to retry", animated: false)
            .addTapHandler({
                self.retrieveToken()
            }, subtitle: "Do you have an internet connection?")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Aldo.setHostAddress(address: hostAddress)
        self.retrieveToken()
    }

    /// Sends a request to retrieve a token if not available,
    /// otherwise starts the view corresponding to the role of the player.
    func retrieveToken() {
        if Aldo.hasAuthToken() {
            var identifier = "startMainMenu"
            if let player = Aldo.getPlayer() {
                identifier = "continueJoinSession"
                if player.isAdmin() {
                    identifier = "continueAdminSession"
                }
            }
            self.performSegue(withIdentifier: identifier, sender: nil)
            return
        }

        SwiftSpinner.sharedInstance.outerColor = nil
        SwiftSpinner.show(delay: 0.0, title: "Setting up", animated: true)
        Aldo.requestAuthToken(callback: self)
    }
}
