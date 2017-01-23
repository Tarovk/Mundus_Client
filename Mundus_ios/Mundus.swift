//
//  Requests.swift
//  Mundus_ios
//
//  Created by Stephan on 10/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//

import UIKit
import Aldo

public enum MundusRequestURI: String {
    
    case REQUEST_QUESTION = "/Aldo/question"
    case REQUEST_PUBLICATIONS = "/Aldo/publications"
    case REQUEST_ASSIGNED = "/Aldo/assigned"
    case REQUEST_PLAYER_PUBLICATIONS = "/Aldo/players"
    case REQUEST_SUBMIT_ANSWER = "/Aldo/question/%@/answer"
    case REQUEST_GET_SUBMITTED = "/Aldo/submitted"
    case REQUEST_REVIEW = "/Aldo/question/%@/review"

}

public class Mundus {

    public class func getSubmittedQuestions(callback: Callback? = nil) {
        Aldo.request(uri: MundusRequestURI.REQUEST_GET_SUBMITTED.rawValue, method: .get, parameters: [:], callback: callback)
    }

    public class func submitQuestion(callback: Callback? = nil, answer : String, questionId: String) {
        let command: String = String(format: MundusRequestURI.REQUEST_SUBMIT_ANSWER.rawValue, questionId)
        Aldo.request(uri: command, method: .post, parameters: ["answer" : answer], callback: callback)
    }

    public class func getQuestion(callback: Callback? = nil) {
       Aldo.request(uri: MundusRequestURI.REQUEST_QUESTION.rawValue, method: .get, parameters: [:], callback: callback)
    }

    public class func getPublications(callback: Callback? = nil) {
        Aldo.request(uri: MundusRequestURI.REQUEST_PUBLICATIONS.rawValue, method: .get, parameters: [:], callback: callback)
    }

    public class func getAssignedQuestions(callback: Callback? = nil) {
        Aldo.request(uri: MundusRequestURI.REQUEST_ASSIGNED.rawValue, method: .get, parameters: [:], callback: callback)
    }

    public class func getPubPlayers(callback: Callback? = nil) {
        Aldo.request(uri: MundusRequestURI.REQUEST_PLAYER_PUBLICATIONS.rawValue, method: .get, parameters: [:], callback: callback)
    }

    public class func reviewQuestion(callback: Callback? = nil, review : String, questionId: String) {
        let command: String = String(format: MundusRequestURI.REQUEST_REVIEW.rawValue, questionId)
        Aldo.request(uri: command, method: .put, parameters: ["reviewed" : review], callback: callback)
    }



}
