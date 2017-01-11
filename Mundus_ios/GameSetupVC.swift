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

    @IBOutlet weak var CreateButton: UIButton!
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var JoinButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var items = NSDictionary()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(Aldo.hasSession()) {
            print("ik heb sessie")
            if (Aldo.getStoredSession()!.isAdmin()) {
                print("ik ben admin")
                succesfullCreate()
            } else {
                print(Aldo.getStoredSession()!.getSessionID() + "   " + Aldo.getStoredSession()!.getPlayerID())
                print("ik geen ben admin")
                succesfullJoin()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        JoinButton.layer.cornerRadius = 5
        CreateButton.layer.cornerRadius = 5
    }
//    let BASE_API_URL : String = "https://expeditionmundus.herokuapp.com"


    func onResponse(request: String, responseCode: Int, response: NSDictionary) {
        self.indicator.stopAnimating()
        if(responseCode == 200) {
            switch request {
            case Regex(pattern: AldoRequest.SESSION_CREATE.regex()):
                succesfullCreate()
                break
            case Regex(pattern: AldoRequest.SESSION_JOIN.regex()):
                succesfullJoin()
                break
            default:
                return;
            }
        } else {
            Toast(text: response.object(forKey: "halt") as! String).show()
        }
    }

    public func succesfullCreate() {
        performSegue(withIdentifier: "adminSegue", sender: nil)
    }

    @IBAction func createGame(_ sender: Any) {
        if(!nameIsEmpty()) {
            self.indicator.startAnimating()
            Aldo.createSession(username: inputName.text!, callback: self)
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
        if(!nameIsEmpty()){
            self.indicator.startAnimating()
            let alert = UIAlertController(title: "Join token", message: "Vul de token in", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.text = ""
            }
            var textString = ""
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert!.textFields![0]
                textString = textField.text!
                Aldo.joinSession(username: self.inputName.text!, token: textString, callback: self)
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

    //Callback
    func succesfullJoin(){
        performSegue(withIdentifier: "playerSegue", sender: nil)
    }


}

