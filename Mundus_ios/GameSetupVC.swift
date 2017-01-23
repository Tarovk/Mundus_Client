//
//  GameSetupVC.swift
//  Mundus_ios
//
//  Created by Stephan on 19/12/2016.
//  Copyright © 2016 Stephan. All rights reserved.
//

import UIKit
import Alamofire
import Aldo
import Toaster


class GameSetupVC: UIViewController, Callback {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var createGameButton: UIButton!
    @IBOutlet weak var joinGameButton: UIButton!
    @IBOutlet weak var mainIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let player = Aldo.getPlayer() {
            if player.isAdmin() {
                succesfullCreate()
                return
            }
            succesfullJoin()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.joinGameButton.layer.cornerRadius = 5
        self.createGameButton.layer.cornerRadius = 5
    }

    func onResponse(request: String, responseCode: Int, response: NSDictionary) {
        self.mainIndicator.stopAnimating()
        if responseCode == 200 {
            switch request {
            case Regex(pattern: RequestURI.SESSION_CREATE.regex()):
                succesfullCreate()
                break
            case Regex(pattern: RequestURI.SESSION_JOIN.regex()):
                succesfullJoin()
                break
            default:
                break;
            }
            return
        }
        Toast(text: "The token you entered is not valid").show()
    }

    public func succesfullCreate() {
        performSegue(withIdentifier: "adminSegue", sender: nil)
    }
    
    //Callback
    func succesfullJoin(){
        performSegue(withIdentifier: "playerSegue", sender: nil)
    }

    @IBAction func createGame(_ sender: Any) {
        if !nameIsEmpty() {
            self.mainIndicator.startAnimating()
            let username = usernameField.text!.replacingOccurrences(of: " ", with: "_")
            Aldo.createSession(username: username, callback: self)
        }
    }

    func nameIsEmpty() -> Bool {
        if self.usernameField.text!.isEmpty {
            Toast(text: "Enter a valid username").show()
            return true;
        }
        return false;
    }

    @IBAction func joinGame(_ sender: Any) {
        if !nameIsEmpty() {
            self.mainIndicator.startAnimating()
            
            let message = "Enter the token of the game you want to join."
            let alert = UIAlertController(title: "Join Game", message: message, preferredStyle: .alert)
            let username = self.usernameField.text!
            
            alert.addTextField { (textField) in
                textField.text = ""
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert!.textFields![0]
                let token = textField.text!
                
                Aldo.joinSession(username: username, token: token, callback: self)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
//
//    override func prepare(`for` segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "adminSegue" {
//            let Pr : UITabBarController = segue.destination as! UITabBarController
//            var dashBoard: AdminDashBoard = Pr.viewControllers![0] as! AdminDashBoard
//            dashBoard.items = items
//            dashBoard.usname = inputName.text!
//        }
//        super.prepare(`for`: segue, sender: sender)
//    }


}

