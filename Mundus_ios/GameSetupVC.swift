//
//  GameSetupVC.swift
//  Mundus_ios
//
//  Created by Team Aldo on 19/12/2016.
//  Copyright © 2016 Team Aldo. All rights reserved.
//

import UIKit
import Alamofire
import Aldo
import Toaster

class GameSetupVC: UIViewController, Callback {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var createGameButton: UIButton!
    @IBOutlet weak var joinGameButton: UIButton!
    @IBOutlet weak var mainIndicator: UIActivityIndicatorView!

    private var loginViewOriginY: CGFloat = 0

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    /// Checks whether to go to the Admin dashboard or the User dashboard.
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

        self.loginViewOriginY = self.loginView.frame.origin.y

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    func keyboardWillShow(notification: NSNotification) {

        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.loginView.frame.origin.y == self.loginViewOriginY {
                self.loginView.frame.origin.y -= keyboardSize.height
            }
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        if (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue != nil {
            if self.loginView.frame.origin.y != 0 {
                self.loginView.frame.origin.y = self.loginViewOriginY
            }
        }
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
                break
            }
            return
        }
        Toast(text: "The token you entered is not valid").show()
    }

    /// Starts the Admin panel.
    public func succesfullCreate() {
        performSegue(withIdentifier: "adminSegue", sender: nil)
    }

    /// Starts the user panel.
    func succesfullJoin() {
        performSegue(withIdentifier: "playerSegue", sender: nil)
    }

    /// Sends a create request to the server running the Aldo Framework.
    @IBAction func createGame(_ sender: Any) {
        if !nameIsEmpty() {
            self.mainIndicator.startAnimating()
            let username = usernameField.text!.replacingOccurrences(of: " ", with: "_")
            Aldo.createSession(username: username, callback: self)
        }
    }

    /**
        Checks whether the user entered a name.
     
        - Returns: *True* if a name is entered, otherwise *false*.
     */
    func nameIsEmpty() -> Bool {
        if self.usernameField.text!.isEmpty {
            Toast(text: "Enter a valid username").show()
            return true
        }
        return false
    }

    /// Sends a join request to the server running the Aldo Framework.
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

}
