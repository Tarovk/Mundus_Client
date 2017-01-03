//
//  AdminVC.swift
//  Mundus_ios
//
//  Created by Stephan on 02/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//

import UIKit
import Starscream

class AdminVC: UIViewController, WebSocketDelegate {
    let socket = WebSocket(url: URL(string: "ws://expeditionmundus.herokuapp.com/echo")!)
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        self.socket.delegate = self
        self.socket.disableSSLCertValidation = true
        self.socket.headers["Authorization"] = userDefaults.object(forKey : "auth") as! String

        self.socket.connect()
        // Do any additional setup after loading the view.
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


}
