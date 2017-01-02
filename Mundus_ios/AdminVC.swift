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
    override func viewDidLoad() {
        super.viewDidLoad()
        print("llolO")

        self.socket.delegate = self
        self.socket.disableSSLCertValidation = true

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
