//
//  SessionPlayersTVC.swift
//  Mundus_ios
//
//  Created by Stephan on 04/01/2017.
//  Copyright © 2017 Stephan. All rights reserved.
//

import UIKit
import Alamofire
import Aldo

struct cellData {
    let username : String!
    let score : String!
    let playerID: String!
}

class SessionPlayersTVC: UITableViewController, Callback {

    var cellDataArrray = [cellData]()
    var players : NSMutableArray = NSMutableArray()
    let BASE_API_URL : String = "http://192.1hehe68.0.75:4567/"

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Publications", image: UIImage(named: "publications"), tag: 1)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.separatorStyle = .none
        retrievePlayers()
    }

    override func tableView(_  tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("PublicationCell", owner: self)?.first as! PublicationCell
        cell.username.text = (players[indexPath.item] as! NSDictionary).object(forKey: "username") as! String
        cell.score.text = (players[indexPath.item] as! NSDictionary).object(forKey: "score") as! String
        return cell
    }

    override func tableView(_ tableView : UITableView, heightForRowAt indexPath : IndexPath) -> CGFloat {
        return 300
    }

    override  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }


    func onResponse(request: String, responseCode: Int, response: NSDictionary) {
//        print(response)
        print(responseCode)
        if(responseCode == 200) {
            players = (response.object(forKey: "players") as! NSArray).mutableCopy() as! NSMutableArray
            print(players)
            self.tableView.reloadData()
        }
    }

    func retrievePlayers() {
        Requests.getPubPlayers(callback: self)
    }

}
