//
//  Requests.swift
//  Mundus_ios
//
//  Created by Team Aldo on 10/01/2017.
//  Copyright (c) 2017 Team Aldo. All rights reserved.
//

import UIKit
import Starscream
import Aldo

/// Specific URI commands for Expedition Mundus.
public enum MundusRequestURI: String {
    case REQUEST_QUESTION = "/Aldo/question"
    case REQUEST_PUBLICATIONS = "/Aldo/publications"
    case REQUEST_ASSIGNED = "/Aldo/assigned"
    case REQUEST_PLAYER_PUBLICATIONS = "/Aldo/players"
    case REQUEST_SUBMIT_ANSWER = "/Aldo/question/%@/answer"
    case REQUEST_GET_SUBMITTED = "/Aldo/submitted"
    case REQUEST_REVIEW = "/Aldo/question/%@/review"
}

/// Class containing static methods to send Mundus specific
/// requests using the Aldo Client Library.
public class Mundus {

    /**
        Sends a request to retrieve all submitted answers in a session.
     
        - Parameter callback: A realization of the Callback protocol to be called
                              when a response is returned from the Aldo Framework.
     
     */
    public class func getSubmittedQuestions(callback: Callback? = nil) {
        Aldo.request(uri: MundusRequestURI.REQUEST_GET_SUBMITTED.rawValue,
                     method: .get, parameters: [:], callback: callback)
    }

    /**
        Sends a request to submit an answer.
     
        - Parameter callback: A realization of the Callback protocol to be called
                              when a response is returned from the Aldo Framework.
     
     */
    public class func submitQuestion(callback: Callback? = nil,
                                     answer: String, questionId: String) {
        let command: String = String(format: MundusRequestURI.REQUEST_SUBMIT_ANSWER.rawValue, questionId)
        Aldo.request(uri: command, method: .post, parameters: ["answer": answer], callback: callback)
    }

    /**
        Sends a request to retrieve a question.
     
        - Parameter callback: A realization of the Callback protocol to be called
                              when a response is returned from the Aldo Framework.
     
     */
    public class func getQuestion(callback: Callback? = nil) {
       Aldo.request(uri: MundusRequestURI.REQUEST_QUESTION.rawValue, method: .get, parameters: [:], callback: callback)
    }

    /**
        Sends a request to retrieve all publications in a session.
     
        - Parameter callback: A realization of the Callback protocol to be called
                              when a response is returned from the Aldo Framework.
     
     */
    public class func getPublications(callback: Callback? = nil) {
        Aldo.request(uri: MundusRequestURI.REQUEST_PUBLICATIONS.rawValue,
                     method: .get, parameters: [:], callback: callback)
    }

    /**
        Sends a request to retrieve all assigned questions.
     
        - Parameter callback: A realization of the Callback protocol to be called
                              when a response is returned from the Aldo Framework.
     
     */
    public class func getAssignedQuestions(callback: Callback? = nil) {
        Aldo.request(uri: MundusRequestURI.REQUEST_ASSIGNED.rawValue,
                     method: .get, parameters: [:], callback: callback)
    }

    /**
        Sends a request to retrieve all players including their publications.
     
        - Parameter callback: A realization of the Callback protocol to be called
                              when a response is returned from the Aldo Framework.
     
     */
    public class func getPubPlayers(callback: Callback? = nil) {
        Aldo.request(uri: MundusRequestURI.REQUEST_PLAYER_PUBLICATIONS.rawValue,
                     method: .get, parameters: [:], callback: callback)
    }

    /**
        Sends a request to update the review status of a question answered by a user.
     
        - Parameters:
            - callback: A realization of the Callback protocol to be called
                        when a response is returned from the Aldo Framework.
            - review: The new status of the question.
            - questionId: The id of the question.
     
     */
    public class func reviewQuestion(callback: Callback? = nil, review: String, questionId: String) {
        let command: String = String(format: MundusRequestURI.REQUEST_REVIEW.rawValue, questionId)
        Aldo.request(uri: command, method: .put, parameters: ["reviewed": review], callback: callback)
    }
}
