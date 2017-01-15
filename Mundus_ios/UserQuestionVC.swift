//
//  UserQuestionVC.swift
//  Mundus_ios
//
//  Created by Stephan on 10/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//

import UIKit
import Aldo

class UserQuestionVC: UITableViewController, Callback {

    var cellDataArrray = [GroupCellData]()
    var questions : NSMutableArray = NSMutableArray()

    func onResponse(request: String, responseCode: Int, response: NSDictionary) {
        if(responseCode == 200) {
            switch request {
            case MundusRequest.REQUEST_ASSIGNED.rawValue:
                questions = (response.object(forKey: "questions") as! NSArray).mutableCopy() as! NSMutableArray
                print(questions)
                refreshControl!.endRefreshing()
                if(questions.count < 3) {
                    Requests.getQuestion(callback: self)
                }
                if questions.count == 0 {
                    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
                    label.text             = "No questions left"
                    label.textColor        = UIColor.black
                    label.textAlignment    = .center
                    tableView.backgroundView = label
                    tableView.separatorStyle = .none
                }
                break;
            default:
                Requests.getAssignedQuestions(callback: self)
                break;
            }
        }
        self.tableView.reloadData()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "My questions", image: UIImage(named: "userwrite"), tag: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false;
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: "refresh", for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl!)
        edgesForExtendedLayout = []
        self.tabBarController!.tabBar.backgroundColor = UIColor.white
        self.tableView!.separatorStyle = .none
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }

    func refresh() {
        Requests.getAssignedQuestions(callback: self)
    }

    override func tableView(_  tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("UserQuestionCell", owner: self)?.first as! UserQuestionCell
        let review : String = (questions[indexPath.item] as! NSDictionary).object(forKey: "reviewed") as! String
        if review == "-2" {
            cell.setActive()
        } else if review == "-1" {
            cell.setUnderReview()
        } else if review == "0" {
            cell.setDeclined()
        }
        cell.questionId = (questions[indexPath.item] as! NSDictionary).object(forKey: "question_id") as! String
        cell.question.text = (questions[indexPath.item] as! NSDictionary).object(forKey: "question") as! String
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    override func tableView(_ tableView : UITableView, heightForRowAt indexPath : IndexPath) -> CGFloat {
        return 300
    }

}
