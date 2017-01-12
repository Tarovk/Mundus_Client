//
//  Requests.swift
//  Mundus_ios
//
//  Created by Stephan on 10/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//

import UIKit
import Aldo
public enum MundusRequest: String {
    case REQUEST_QUESTION = "/Aldo/question"
    case REQUEST_PUBLICATIONS = "/Aldo/publications"
    case REQUEST_ASSIGNED = "/Aldo/assigned"
    case REQUEST_PLAYER_PUBLICATIONS = "/Aldo/players"
    case REQUEST_SUBMIT_ANSWER = "/Aldo/question/%@/answer"

}

open class Requests {

    open class func submitQuestion(callback: Callback? = nil, answer : String, questionId: String) {
        let command: String = String(format: MundusRequest.REQUEST_SUBMIT_ANSWER.rawValue, questionId)
        Aldo.request(command: command, method: .post, parameters: ["answer" : answer], callback: callback)
    }

    open class func getQuestion(callback: Callback? = nil) {
       Aldo.request(command: MundusRequest.REQUEST_QUESTION.rawValue, method: .get, parameters: [:], callback: callback)
    }

    open class func getPublications(callback: Callback? = nil) {
        Aldo.request(command: MundusRequest.REQUEST_PUBLICATIONS.rawValue, method: .get, parameters: [:], callback: callback)
    }

    open class func getAssignedQuestions(callback: Callback? = nil) {
        Aldo.request(command: MundusRequest.REQUEST_ASSIGNED.rawValue, method: .get, parameters: [:], callback: callback)
    }

   open class func getPubPlayers(callback: Callback? = nil) {
        Aldo.request(command: MundusRequest.REQUEST_PLAYER_PUBLICATIONS.rawValue, method: .get, parameters: [:], callback: callback)
    }



}
