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

    var cellDataArrray = [groupCellData]()
    var questions : NSMutableArray = NSMutableArray()

    func onResponse(request: String, responseCode: Int, response: NSDictionary) {
        if(responseCode == 200) {
            switch request {
            case MundusRequest.REQUEST_ASSIGNED.rawValue:
                questions = (response.object(forKey: "questions") as! NSArray).mutableCopy() as! NSMutableArray
                
                if(questions.count < 3) {
                    Requests.getQuestion(callback: self)
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

        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "My questions", image: UIImage(named: "userwrite"), tag: 0)
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        self.tableView!.separatorStyle = .none
        Requests.getAssignedQuestions(callback: self)
    }

    override func tableView(_  tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("UserQuestionCell", owner: self)?.first as! UserQuestionCell
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
