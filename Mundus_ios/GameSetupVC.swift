//
//  GameSetupVC.swift
//  Mundus_ios
//
//  Created by Stephan on 19/12/2016.
//  Copyright © 2016 Stephan. All rights reserved.
//

import UIKit
import Alamofire
import Toaster


class GameSetupVC: UIViewController {

    @IBOutlet weak var inputName: UITextField!
    let BASE_API_URL : String = "http://192.168.0.75:4567/"
    var auth_token : String = ""
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

            // Do any additional setup after loading the view, typically from a nib.
        
        // Dispose of any resources that can be recreated.
    }

    @IBAction func createGame(_ sender: Any) {

        print(UserDefaults.standard.object(forKey: "auth") as! String)
        if(!nameIsEmpty()) {
            self.indicator.startAnimating()
            let headers : HTTPHeaders = [
                    "Authorization": UserDefaults.standard.object(forKey : "auth") as! String
            ]

            Alamofire.request(BASE_API_URL + "createSession/username/" + inputName.text!, method: .post, headers : headers).responseJSON { response in
                        print(response.result)   // result of response serialization

                        if let result = response.result.value {
                            let JSON = result as! NSDictionary


                            print("JSON: \(JSON)")
                            self.indicator.stopAnimating()
                            self.performSegue(withIdentifier: "adminSegue", sender: nil)
                        }
                    }
        }

    }
    func nameIsEmpty() -> Bool {
        if(inputName.text!.isEmpty) {
            Toast(text: "Vul alstublieft een naam in").show()

            return true;
        }
        return false;
    }
    @IBAction func joinGame(_ sender: Any) {
        let alert = UIAlertController(title: "Join token", message: "Vul de token in", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
        }
        var textString = ""
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0]
            textString = textField.text!
            print("Text field: \(textField.text)")
            self.createJoinRequest(textString: textString)
        }))

        self.present(alert, animated: true, completion: nil)

    }

    func createJoinRequest(textString : String) {
        let parameters: Parameters = [
                "deviceID": (UIDevice.current.identifierForVendor?.uuidString)!,
                "token": auth_token,
                "joinToken": textString
        ]
        Alamofire.request(BASE_API_URL + "session/join", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                    print(response.result)   // result of response serialization

                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                }
    }
}

