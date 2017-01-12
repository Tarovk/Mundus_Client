//
//  AdminDashBoard.swift
//  Mundus_ios
//
//  Created by Stephan on 04/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//
import Aldo 
import UIKit

class AdminDashBoard: UIViewController, Callback {

    @IBOutlet weak var gameStateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var adminToken: UILabel!
    @IBOutlet weak var userJoinToken: UILabel!
    @IBOutlet weak var username: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        styleButton()
        let session : AldoSession = Aldo.getStoredSession()!
        username.text = session.getUsername()
        userJoinToken.text =  session.getUserToken()
        adminToken.text = session.getModToken()
    }

    func styleButton() {
        deleteButton.layer.cornerRadius = 5
        gameStateButton.layer.cornerRadius = 5
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(named: "dashboard"), tag: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func changeStateClicked(_ sender: Any) {
        if(gameStateButton.titleLabel!.text! == "Play") {
            Aldo.changeSessionState(newState: AldoSession.State.PLAY, callback: self)
        } else if(gameStateButton.titleLabel!.text! == "Pause") {
            Aldo.changeSessionState(newState: AldoSession.State.PAUSE, callback: self)
        }
    }

    @IBAction func deleteClicked(_ sender: Any) {
        Aldo.deleteSession(callback: self)
    }
    
    func onResponse(request: String, responseCode: Int, response: NSDictionary) {
        print(responseCode)
        if(responseCode == 200) {
            switch request {

            case Regex(pattern: AldoRequest.SESSION_STATE_PLAY.regex()):
                gameStateButton.titleLabel!.text! = "Pause"
                gameStateButton.backgroundColor = UIColor.orange
                print("play worked")
                break

            case Regex(pattern: AldoRequest.SESSION_STATE_PAUSE.regex()):
                gameStateButton.titleLabel!.text! = "Play"
                gameStateButton.backgroundColor = UIColor.green
                print("pauze worked")
                break
            case Regex(pattern: AldoRequest.SESSION_DELETE.regex()):
                print("delete done")
                print(Aldo.hasSession())
                self.dismiss(animated: true, completion: {});
            break;
            default:
                break
            }
        }
    }

}
