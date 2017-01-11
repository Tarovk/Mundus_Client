//
//  PublicationCell.swift
//  Mundus_ios
//
//  Created by Stephan on 10/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//

import UIKit

class PublicationCell: UITableViewCell, UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }


    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var pubTable: UITableView!

    let section = ["pizza", "deep dish pizza", "calzone"]

    let items = [["Margarita", "BBQ Chicken", "Pepperoni"], ["sausage", "meat lovers", "veggie lovers"], ["sausage", "chicken pesto", "prawns", "mushrooms"]]


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[0].count
    }

    func numberOfSections(`in` tableView: UITableView) -> Int {
        return section.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SessionPlayerCell", owner: self)?.first as! SessionPlayerCell
        cell.playerName.text = items[indexPath.section][indexPath.row]
        return cell
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        pubTable.dataSource = self
        username.text = "lol"
        score.text = "5550"

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
