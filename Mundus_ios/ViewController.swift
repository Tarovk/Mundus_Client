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

    let BASE_API_URL : String = "http://192.168.0.75:4567/"
    var auth_token : String = ""
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        postToken()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postToken() -> Void {
        let headers : HTTPHeaders = [
            "Authorization": (UIDevice.current.identifierForVendor?.uuidString)!
        ]
        Alamofire.request(BASE_API_URL + "token", method: .post, headers: headers).responseJSON { response in

            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                let dict = JSON as! NSDictionary
                let token = dict.object(forKey: "token")!
                let deviceId = dict.object(forKey: "deviceID")!
                let stringCombine = "\(deviceId):\(token)"
                self.userDefaults.set(stringCombine, forKey: "auth")
                
                print("JSON: \(JSON)")
            }
        }
    }

    @IBAction func createGame(_ sender: Any) {
        let alert = UIAlertController(title: "Naam", message: "Kies alstublieft een naam", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = "naam"
        }
        var textString = ""
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            textString = textField.text!
            print("Text field: \(textField.text)")
            self.createGameRequest(textString: textString)
        }))

        self.present(alert, animated: true, completion: nil)


    }

    func createGameRequest(textString : String) {
        print(userDefaults.object(forKey: "auth") as! String)
        let headers : HTTPHeaders = [
                "Authorization": userDefaults.object(forKey : "auth") as! String
        ]

        Alamofire.request(BASE_API_URL + "createSession/username/" + textString, method: .post, headers : headers).responseJSON { response in
                    print(response.result)   // result of response serialization

                    if let result = response.result.value {
                        let JSON = result as! NSDictionary


                        print("JSON: \(JSON)")
                        self.performSegue(withIdentifier: "adminSegue", sender: nil)
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

