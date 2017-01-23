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
        return UITableViewAutomaticDimension

    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension

    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "I'am a test label"
        return label
    }


    @IBOutlet weak var noPubs: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var pubTable: UITableView!
    var publications: NSMutableArray = NSMutableArray() {
        didSet {
            pubTable.reloadData()
            noPubs.isHidden = publications.count > 0
        }
    }

    var section = ["pizza", "deep dish pizza", "calzone"]

    var items = [["Margarita", "BBQ Chicken", "Pepperoni"], ["sausage", "meat lovers", "veggie lovers"], ["sausage", "chicken pesto", "prawns", "mushrooms"]]


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(`in` tableView: UITableView) -> Int {
        return publications.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ((publications[section] as! NSDictionary).object(forKey: "question") as! String)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SessionPlayerCell", owner: self)?.first as! SessionPlayerCell
        cell.playerName.text = ((publications[indexPath.section] as! NSDictionary).object(forKey: "correct_answer") as! String)
        return cell
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        pubTable.dataSource = self
        noPubs.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
