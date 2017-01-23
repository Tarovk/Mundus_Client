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

    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    var cellDataArrray = [GroupCellData]()
    var questions : NSMutableArray = NSMutableArray()

    func onResponse(request: String, responseCode: Int, response: NSDictionary) {
        if(responseCode == 200) {
            switch request {
            case MundusRequestURI.REQUEST_ASSIGNED.rawValue:
                questions = (response.object(forKey: "questions") as! NSArray).mutableCopy() as! NSMutableArray
                refreshControl!.endRefreshing()
                if(questions.count < 3) {
                    Mundus.getQuestion(callback: self)
                }
                updateEmptyMessage()
                break;
            default:
                Mundus.getAssignedQuestions(callback: self)
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
        
        edgesForExtendedLayout = []
        self.tabBarController!.tabBar.backgroundColor = UIColor.white
        self.tableView.allowsSelection = false;
        self.tableView!.separatorStyle = .none
        
        initEmptyMessage()
        initRefreshControl()
        refresh()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backgroundImage = UIImageView(image: UIImage(named: "lightwood"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.layer.zPosition = -1
        self.tableView.backgroundView = backgroundImage
    }

    private func initEmptyMessage() {
        label.textColor        = UIColor.black
        label.textAlignment    = .center
        tableView.backgroundView = label
        tableView.separatorStyle = .none
        
        updateEmptyMessage()
    }
    
    private func initRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(UserQuestionVC.refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    private func updateEmptyMessage() {
        var text = ""
        if questions.count == 0 {
            text = "No questions left"
        }
        label.text = text
    }
    
    func refresh() {
        Mundus.getAssignedQuestions(callback: self)
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
        cell.backgroundColor = .clear
        cell.questionId = (questions[indexPath.item] as! NSDictionary).object(forKey: "question_id") as! String
        cell.question.text = ((questions[indexPath.item] as! NSDictionary).object(forKey: "question") as! String)
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    override func tableView(_ tableView : UITableView, heightForRowAt indexPath : IndexPath) -> CGFloat {
        return 300
    }

}
