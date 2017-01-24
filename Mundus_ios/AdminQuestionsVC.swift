//
//  AdminQuestionsVC.swift
//  Mundus_ios
//
//  Created by Stephan on 02/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//

import UIKit
import Aldo

struct GroupCellData {
    let question: String!
    let answer: String!
    let correctAnswer: String!
}
class AdminQuestionsVC: UITableViewController, Callback, ReviewCallback {

    var cellDataArrray = [GroupCellData]()
    var questions: NSMutableArray = NSMutableArray()
    var socket: AldoWebSocket?

    func onResponse(request: String, responseCode: Int, response: NSDictionary) {
        print(response)
        if responseCode == 200 {
            switch request {
            case MundusRequestURI.REQUEST_GET_SUBMITTED.rawValue:
                questions = (response.object(forKey: "answers") as! NSArray).mutableCopy() as! NSMutableArray
                self.tableView.reloadData()
                break
            default:
                refresh()
                break
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Question feed", image: UIImage(named: "qfeed"), tag: 0)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    func refresh() {
        Mundus.getSubmittedQuestions(callback: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.separatorStyle = .none
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "lightwood"))
        tableView.allowsSelection = false
        Mundus.getSubmittedQuestions(callback: self)
        edgesForExtendedLayout = []
        self.tabBarController!.tabBar.backgroundColor = UIColor.white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if socket == nil {
            socket = Aldo.subscribe(path: "/subscribe/answer", callback: self)
            return
        }
        socket!.connect()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if socket != nil {
            self.socket!.disconnect()
        }
    }

    func onResponse(qId: String) {
        for i in 0...questions.count {
            let id: String = (questions[i] as! NSDictionary).object(forKey: "question_id") as! String
            if id == qId {
                questions.removeObject(at: i)
                self.tableView!.reloadData()
                break
            }
        }
    }

    override func tableView(_  tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("AdminQuestionCell", owner: self)?.first as! AdminQuestionCell
        cell.callback = self

        cell.questionId.text = ((questions[indexPath.item] as! NSDictionary).object(forKey: "question_id") as! String)
        cell.question.text = ((questions[indexPath.item] as! NSDictionary).object(forKey: "question") as! String)
        cell.answer.text = ((questions[indexPath.item] as! NSDictionary).object(forKey: "answer") as! String)
        cell.correctAnswer.text = ((questions[indexPath.item] as! NSDictionary)
            .object(forKey: "correct_answer") as! String)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 358
    }

}
