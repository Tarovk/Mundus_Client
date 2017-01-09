//
//  TokenVC.swift
//  Mundus_ios
//
//  Created by Stephan on 03/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//

import UIKit
import SwiftSpinner
import Alamofire
import Aldo


class TokenVC: UIViewController, Callback {
    let BASE_API_URL : String = "https://expeditionmundus.herokuapp.com"

    func onResponse(request : String, responseCode: Int, response: NSDictionary) {
        print(responseCode)
        if(responseCode == 200) {
            SwiftSpinner.setTitleFont(nil)
            SwiftSpinner.sharedInstance.innerColor = UIColor.green.withAlphaComponent(0.5)
            SwiftSpinner.show(duration: 2.0, title: "Connected", animated: false)
            self.performSegue(withIdentifier: "retrievedToken", sender: nil)
        } else {
            SwiftSpinner.sharedInstance.outerColor = UIColor.red.withAlphaComponent(0.5)
            SwiftSpinner.show("Failed to connect, tap to retry", animated: false)
                    .addTapHandler({
                        print("tapped")
                        self.retrieveToken()
                    }, subtitle: "Do you have internet connection?")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Aldo.setHostAddress(address: BASE_API_URL, port: 4567)
        self.retrieveToken()
    }

    func retrieveToken() {
          if(Aldo.hasAuthToken()) {
            self.performSegue(withIdentifier: "retrievedToken", sender: nil)
        } else {
            SwiftSpinner.sharedInstance.outerColor = nil
            SwiftSpinner.show(delay: 0.0, title: "Setting up", animated: true)
            Aldo.requestAuthToken(callback: self)
        }
    }




}

