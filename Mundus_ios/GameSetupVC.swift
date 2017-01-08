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


class GameSetupVC: UIViewController {

    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var items = NSDictionary()
//    let BASE_API_URL : String = "https://expeditionmundus.herokuapp.com"

    private class CreateGameSessionCallback : Callback{
        private var viewController : GameSetupVC

         public init(viewController: GameSetupVC) {
             self.viewController = viewController
        }
        func onResponse(responseCode: Int, response: NSDictionary) {
            if(responseCode == 200) {
                print("meeeh")
                viewController.succesfullCreate(response: response)
            }
        }
    }
    
    private class JoinSessionCallback : Callback{
        private var viewController : GameSetupVC
        
        public init(viewController: GameSetupVC) {
            self.viewController = viewController
        }
        func onResponse(responseCode: Int, response: NSDictionary) {
            print("jaja")
            print(response)
            if(responseCode == 200) {
                print("meeeh")
                print(response)
                viewController.succesfullJoin(response: response)
            } else {
                Toast(text: response.object(forKey: "halt") as! String).show()
            }
        }
    }

    public func succesfullCreate(response:NSDictionary) {
        items = response
        indicator.stopAnimating()
        performSegue(withIdentifier: "adminSegue", sender: nil)
    }

    @IBAction func createGame(_ sender: Any) {
        if(!nameIsEmpty()) {
            self.indicator.startAnimating()
            Aldo.createSession(username: inputName.text!, callback: CreateGameSessionCallback(viewController: self))
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
                Aldo.joinSession(username: self.inputName.text!, token: textString, callback: JoinSessionCallback(viewController: self))
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func prepare(`for` segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adminSegue" {
            let Pr : UITabBarController = segue.destination as! UITabBarController
            var dashBoard: AdminDashBoard = Pr.viewControllers![0] as! AdminDashBoard
            dashBoard.items = items
            dashBoard.usname = inputName.text!
        }
        super.prepare(`for`: segue, sender: sender)
    }

    //Callback
    func succesfullJoin(response:NSDictionary){
        self.indicator.stopAnimating()
        performSegue(withIdentifier: "playerSegue", sender: nil)
    }


}

