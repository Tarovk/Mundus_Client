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
    
    var progress = 0.0
    let BASE_API_URL : String = "http://192.168.0.75/"


    
    func onResponse(responseCode: Int, response: Any) {
        print(response)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(UserDefaults.standard.object(forKey : "auth") != nil) {
            self.performSegue(withIdentifier: "retrievedToken", sender: nil)
            print("ok")
        } else {
            print("niet ok")
            postToken()
        }
//    Aldo.setHostAddress(address: BASE_API_URL, port: 4567)
//        Aldo.requestAuthToken(callback: self)
//        print("ok")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    func postToken() -> Void {
        SwiftSpinner.sharedInstance.outerColor = nil
        SwiftSpinner.show(delay: 0.0, title: "Setting up", animated: true)

        let headers : HTTPHeaders = [
                "Authorization": (UIDevice.current.identifierForVendor?.uuidString)!
        ]
        Alamofire.request(BASE_API_URL + "token", method: .post, headers: headers).responseJSON { response in
                    print(response.response)
                    if (response.result.isSuccess) {
                        if let JSON = response.result.value {
                            let dict = JSON as! NSDictionary
                            let token = dict.object(forKey: "token")!
                            let deviceId = dict.object(forKey: "deviceID")!
                            let stringCombine = "\(deviceId):\(token)"
                            UserDefaults.standard.set(stringCombine, forKey: "auth")
                            SwiftSpinner.setTitleFont(nil)
                            SwiftSpinner.sharedInstance.innerColor = UIColor.green.withAlphaComponent(0.5)
                            SwiftSpinner.show(duration: 2.0, title: "Connected", animated: false)
                            self.performSegue(withIdentifier: "retrievedToken", sender: nil)
                        }
                    } else {
                        SwiftSpinner.sharedInstance.outerColor = UIColor.red.withAlphaComponent(0.5)
                        SwiftSpinner.show("Failed to connect, tap to retry", animated: false)
                                .addTapHandler({
                                    print("tapped")
                                    self.postToken()
                                }, subtitle: "Do you have internet connection?")
                    }
                }


    }



}

