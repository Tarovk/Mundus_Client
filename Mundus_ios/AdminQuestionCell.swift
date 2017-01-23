//
//  SessionPlayerCell.swift
//  Mundus_ios
//
//  Created by Stephan on 04/01/2017.
//  Copyright © 2017 Stephan. All rights reserved.
//

import UIKit
import Aldo

class AdminQuestionCell: UITableViewCell, Callback {

    @IBOutlet weak var questionId: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!
    var delegate: ReviewCallback?

    @IBAction func reject(_ sender: Any) {
        Mundus.reviewQuestion(callback: self, review: "0", questionId: questionId.text!)
        delegate!.onResponse(qId: questionId.text!)
    }

    @IBAction func accept(_ sender: Any) {
        Mundus.reviewQuestion(callback: self, review: "1", questionId: questionId.text!)
        delegate!.onResponse(qId: questionId.text!)
    }

    func onResponse(request: String, responseCode: Int, response: NSDictionary) {
        print(responseCode)
        print(response)
        if responseCode == 200 {

        }
    }

}
