//
//  ViewController.swift
//  Mundus_ios
//
//  Created by Stephan on 19/12/2016.
//  Copyright © 2016 Stephan. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var inputToken: UITextField!

    let BASE_API_URL : String = "http://192.168.178.20:4567/"
    var auth_token : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hoi")
        postToken()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postToken() -> Void {
        let parameters: Parameters = [
            "deviceID": (UIDevice.current.identifierForVendor?.uuidString)!
        ]
        Alamofire.request(BASE_API_URL + "token", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in

            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                let dict = JSON as! NSDictionary
                self.auth_token = dict.object(forKey: "token")! as! String
                
                print("JSON: \(JSON)")
            }
        }
    }

    @IBAction func createGame(_ sender: Any) {
        let parameters: Parameters = [
            "deviceID": (UIDevice.current.identifierForVendor?.uuidString)!,
            "token": auth_token
        ]
        Alamofire.request(BASE_API_URL + "session/create", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }

    @IBAction func joinGame(_ sender: Any) {
        
        let parameters: Parameters = [
            "deviceID": (UIDevice.current.identifierForVendor?.uuidString)!,
            "token": auth_token,
            "joinToken": inputToken.text
        ]
        Alamofire.request(BASE_API_URL + "session/join", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
}

