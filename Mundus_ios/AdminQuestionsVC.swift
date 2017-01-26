//
//  AdminQuestionsVC.swift
//  Mundus_ios
//
//  Created by Team Aldo on 02/01/2017.
//  Copyright (c) 2017 Team Aldo. All rights reserved.
//

import UIKit
import Aldo

/// Data stored for an AdminQuestionCell.
struct GroupCellData {
    let question: String!
    let answer: String!
    let correctAnswer: String!
}

/// ViewController for the Admin question panel.
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

    /// Sends a request to retrieve all submitted answers.
    func refresh() {
        Mundus.getSubmittedQuestions(callback: self)
    }

    /// Changes the background of the panel and retreives the answers.
    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = []
        self.tabBarController!.tabBar.backgroundColor = UIColor.white
        self.tableView.allowsSelection = false
        self.tableView!.separatorStyle = .none

        refresh()
    }

    /// Opens a WebSocket connection if possible when creating the view.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let backgroundImage = UIImageView(image: UIImage(named: "lightwood"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.layer.zPosition = -1
        self.tableView.backgroundView = backgroundImage

        if socket == nil {
            socket = Aldo.subscribe(path: "/subscribe/answer", callback: self)
            return
        }
        socket!.connect()
    }

    /// Closes a WebSocket connection if a connection was established.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if socket != nil {
            self.socket!.disconnect()
        }
    }

    func onReviewed(qId: String) {
        for i in 0...questions.count {
            let id: String = (questions[i] as! NSDictionary).object(forKey: "questionID") as! String
            if id == qId {
                questions.removeObject(at: i)
                self.tableView!.reloadData()
                break
            }
        }
    }

    /// Draws the submitted answers in the panel.
    override func tableView(_  tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("AdminQuestionCell", owner: self)?.first as! AdminQuestionCell
        cell.callback = self

        cell.questionId.text = ((questions[indexPath.item] as! NSDictionary).object(forKey: "questionID") as! String)
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
