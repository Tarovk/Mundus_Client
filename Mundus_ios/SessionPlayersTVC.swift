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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backgroundImage = UIImageView(image: UIImage(named: "lightwood"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.layer.zPosition = -1
        self.tableView.backgroundView = backgroundImage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        self.tabBarController!.tabBar.backgroundColor = UIColor.white
        self.tableView.allowsSelection = false
        self.tableView!.separatorStyle = .none
        
        initRefreshControl()
        refresh()
    }

    override func tableView(_  tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("PublicationCell", owner: self)?.first as! PublicationCell
        
        cell.backgroundColor = .clear
        cell.username.text = ((players[indexPath.item] as! NSDictionary).object(forKey: "username") as! String)
        cell.score.text = ((players[indexPath.item] as! NSDictionary).object(forKey: "score") as! String)
        cell.publications = ((players[indexPath.item] as! NSDictionary).object(forKey: "publications") as! NSArray).mutableCopy() as! NSMutableArray
        return cell
    }

    override func tableView(_ tableView : UITableView, heightForRowAt indexPath : IndexPath) -> CGFloat {
        return 300
    }

    override  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    

    func onResponse(request: String, responseCode: Int, response: NSDictionary) {
        if(responseCode == 200) {
            players = (response.object(forKey: "players") as! NSArray).mutableCopy() as! NSMutableArray
            refreshControl!.endRefreshing()
            self.tableView.reloadData()
        }
    }

    func refresh() {
        Mundus.getPubPlayers(callback: self)
    }
    
    private func initRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(SessionPlayersTVC.refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl!)
    }

}
