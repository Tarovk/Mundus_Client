//
//  AdminQuestionsVC.swift
//  Mundus_ios
//
//  Created by Stephan on 02/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//

import UIKit
import Starscream
import Aldo

struct GroupCellData {
    let question: String!
    let answer: String!
    let correctAnswer: String!
}
class AdminQuestionsVC: UITableViewController, WebSocketDelegate, Callback, ReviewCallback {

    var cellDataArrray = [GroupCellData]()
    var questions: NSMutableArray = NSMutableArray()
    let socket = WebSocket(url: URL(string: "ws://expeditionmundus.herokuapp.com/subscribe/answer")!)

    func onResponse(request: String, responseCode: Int, response: NSDictionary) {
        print(response)
        if responseCode == 200 {
            questions = (response.object(forKey: "answers") as! NSArray).mutableCopy() as! NSMutableArray
            print(questions)
            self.tableView.reloadData()
//            if questions.count == 0 {
//                print("heleaal nix")
//                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//                label.text             = "No questions need reviewing"
//                label.textColor        = UIColor.black
//                label.textAlignment    = .center
//                let imageView : UIImageView =  UIImageView(image: UIImage(named: "lightwood"))
//                tableView.backgroundView = label
//                tableView.separatorStyle = .none
//            } else {
//                tableView.separatorStyle = .singleLine
//                tableView.backgroundView = nil
//            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Question feed", image: UIImage(named: "qfeed"), tag: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func websocketDidConnect(socket: WebSocket) {
        print("websocket is connected")
    }

    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        print("websocket is disconnected: \(error?.localizedDescription)")
    }

    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        if !text.isEmpty {
            refresh()
        }
        print("got some text: \(text)")
    }

    func websocketDidReceiveData(socket: WebSocket, data: Data) {
        print(data)
        print("got some data: \(data.count)")
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

        let ID: String = UIDevice.current.identifierForVendor!.uuidString
        let player: String = Aldo.getPlayer()!.getId()
        let authToken: String = Aldo.getStorage().object(forKey: Aldo.Keys.AUTH_TOKEN.rawValue) as! String
        self.socket.delegate = self

        self.socket.headers["Authorization"] = "\(ID):\(authToken):\(player)"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
        self.socket.connect()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.socket.disconnect()
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
