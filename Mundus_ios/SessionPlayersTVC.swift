//
//  SessionPlayersTVC.swift
//  Mundus_ios
//
//  Created by Stephan on 04/01/2017.
//  Copyright © 2017 Stephan. All rights reserved.
//

import UIKit
import Alamofire

struct cellData {
    let name : String!
    let score : String!
}

class SessionPlayersTVC: UITableViewController {

    var cellDataArrray = [cellData]()
    let BASE_API_URL : String = "http://192.168.0.75:4567/"

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "Deelnemers", image: UIImage(named: "players"), tag: 1)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataArrray.count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        retrievePlayers()
        cellDataArrray = [cellData(name: "Naam: Groepje1", score: "Score: 3"), cellData(name: "Naam: Groepje2", score: "Score: 0"),
        cellData(name: "Naam: Groepje3", score: "Score: 2")]
    }

    override func tableView(_  tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SessionPlayerCell", owner: self)?.first as! SessionPlayerCell
        cell.playerName.text = cellDataArrray[indexPath.row].name
        cell.playerScore.text = cellDataArrray[indexPath.row].score
        return cell
    }

    override func tableView(_ tableView : UITableView, heightForRowAt indexPath : IndexPath) -> CGFloat {
        return 59
    }

    func retrievePlayers() {

    }

}
