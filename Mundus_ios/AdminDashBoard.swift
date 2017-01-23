//
//  AdminDashBoard.swift
//  Mundus_ios
//
//  Created by Stephan on 04/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//
import UIKit
import Aldo

class AdminDashBoard: UIViewController, Callback {
    @IBOutlet weak var gameStateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var adminToken: UILabel!
    @IBOutlet weak var userJoinToken: UILabel!
    @IBOutlet weak var username: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        styleButton()
        let player: Player = Aldo.getPlayer()!
        username.text = player.getUsername()
        userJoinToken.text =  player.getSession().getUserToken()
        adminToken.text = player.getSession().getModeratorToken()
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
        if gameStateButton.titleLabel!.text! == "Play" {
            Aldo.changeSessionStatus(newStatus: Session.Status.PLAYING, callback: self)
        } else if gameStateButton.titleLabel!.text! == "Pause" {
            Aldo.changeSessionStatus(newStatus: Session.Status.PAUSED, callback: self)
        }
    }

    @IBAction func deleteClicked(_ sender: Any) {
        Aldo.deleteSession(callback: self)
    }

    func onResponse(request: String, responseCode: Int, response: NSDictionary) {
        if responseCode == 200 {
            switch request {

            case Regex(pattern: RequestURI.SESSION_STATE_PLAY.regex()):
                gameStateButton.titleLabel!.text! = "Pause"
                gameStateButton.backgroundColor = UIColor.orange
                break

            case Regex(pattern: RequestURI.SESSION_STATE_PAUSE.regex()):
                gameStateButton.titleLabel!.text! = "Play"
                gameStateButton.backgroundColor = UIColor.green
                break
            case Regex(pattern: RequestURI.SESSION_DELETE.regex()):
                self.dismiss(animated: true, completion: {})
            break
            default:
                break
            }
        }
    }

}
