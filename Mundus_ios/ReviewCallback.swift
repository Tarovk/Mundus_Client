//
//  ReviewCallback.swift
//  Mundus_ios
//
//  Created by Team Aldo on 14/01/2017.
//  Copyright (c) 2017 Team Aldo. All rights reserved.
//

import Foundation

/**
    Protocol for defining an action after a review event.
 */
public protocol ReviewCallback {

    /**
         Triggers an action after reviewing a question.
     
        - Parameter: qId: The id of the question.
     */
    func onReviewed(qId: String)
}
