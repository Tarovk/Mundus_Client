//
//  AdminQuestionsVC.swift
//  Mundus_ios
//
//  Created by Stephan on 02/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//

import UIKit
import Starscream

struct groupCellData {
    let playerName : String!
    let question : String!
    let answer: String!
}
class AdminQuestionsVC: UITableViewController, WebSocketDelegate {
    let socket = WebSocket(url: URL(string: "ws://expeditionmundus.herokuapp.com/echo")!)
    let userDefaults = UserDefaults.standard
    var cellDataArrray = [groupCellData]()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "Question feed", image: UIImage(named: "qfeed"), tag: 0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func websocketDidConnect(socket: WebSocket) {
        print("websocket is connected")
    }

    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        print("websocket is disconnected: \(error?.localizedDescription)")
    }

    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        print("got some text: \(text)")
    }

    func websocketDidReceiveData(socket: WebSocket, data: Data) {
        print("got some data: \(data.count)")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataArrray.count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.socket.delegate = self
//        self.socket.disableSSLCertValidation = true
//        self.socket.headers["Authorization"] = userDefaults.object(forKey : "auth") as! String

//        self.socket.connect()
        cellDataArrray = [groupCellData(playerName: "Groepje4",question: "Waarom zijn banenen krom?", answer: "Omdat ze geel zijn"),
                          groupCellData(playerName: "Groepje1",question: "Waarom zijn banenen krom?", answer: "Omdat het kan"),
                          groupCellData(playerName: "Groepje2",question: "Waarom zijn banenen krom?", answer: "Omdat ze geel zijn")]
    }

    override func tableView(_  tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("AdminQuestionCell", owner: self)?.first as! AdminQuestionCell
        cell.playerName.text = cellDataArrray[indexPath.row].playerName
        cell.question.text = cellDataArrray[indexPath.row].question
        cell.answer.text = cellDataArrray[indexPath.row].answer
        return cell
    }

    override func tableView(_ tableView : UITableView, heightForRowAt indexPath : IndexPath) -> CGFloat {
        return 230
    }
}
