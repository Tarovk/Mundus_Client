//
//  SessionPlayersTVC.swift
//  Mundus_ios
//
//  Created by Team Aldo on 04/01/2017.
//  Copyright © 2017 Team Aldo. All rights reserved.
//

import UIKit
import Alamofire
import Aldo

/// Data stored for the SessionPlayerCell.
struct CellData {
    let username: String!
    let score: String!
    let playerID: String!
}

/// ViewController for the publication panel.
class SessionPlayersTVC: UITableViewController, Callback {

    var cellDataArrray = [CellData]()
    var players: NSMutableArray = NSMutableArray()

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

    /// Draws a player with publications in the panel.
    override func tableView(_  tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("PublicationCell", owner: self)?.first as! PublicationCell

        cell.backgroundColor = .clear
        cell.username.text = ((players[indexPath.item] as! NSDictionary).object(forKey: "username") as! String)
        cell.score.text = ((players[indexPath.item] as! NSDictionary).object(forKey: "score") as! String)
        cell.publications = ((players[indexPath.item] as! NSDictionary)
            .object(forKey: "publications") as! NSArray).mutableCopy() as! NSMutableArray
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    override  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    func onResponse(request: String, responseCode: Int, response: NSDictionary) {
        if responseCode == 200 {
            players = (response.object(forKey: "players") as! NSArray).mutableCopy() as! NSMutableArray
            refreshControl!.endRefreshing()
            self.tableView.reloadData()
        }
    }

    /// Sends a request to retrieve the players with their publications.
    func refresh() {
        Mundus.getPubPlayers(callback: self)
    }

    /// Initializes the pull to refresh mechanism.
    private func initRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(SessionPlayersTVC.refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl!)
    }

}
