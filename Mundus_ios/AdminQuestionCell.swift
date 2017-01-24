//
//  SessionPlayerCell.swift
//  Mundus_ios
//
//  Created by Team Aldo on 04/01/2017.
//  Copyright © 2017 Team Aldo. All rights reserved.
//

import UIKit
import Aldo

/// ViewCell for the questions in the Admin question panel.
class AdminQuestionCell: UITableViewCell {

    @IBOutlet weak var questionId: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!
    var callback: ReviewCallback?

    /**
        Sends a request for a negative review.
     */
    @IBAction func reject(_ sender: Any) {
        Mundus.reviewQuestion(callback: nil, review: "0", questionId: questionId.text!)

        if callback != nil {
            callback!.onReviewed(qId: questionId.text!)
        }
    }

    /**
     Sends a request for a postive review.
     */
    @IBAction func accept(_ sender: Any) {
        Mundus.reviewQuestion(callback: nil, review: "1", questionId: questionId.text!)

        if callback != nil {
            callback!.onReviewed(qId: questionId.text!)
        }
    }

}
