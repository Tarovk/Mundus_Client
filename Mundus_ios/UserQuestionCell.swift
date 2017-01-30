//
//  UserQuestionCell.swift
//  Mundus_ios
//
//  Created by Team Aldo on 11/01/2017.
//  Copyright (c) 2017 Team Aldo. All rights reserved.
//

import UIKit
import Aldo
import Alamofire

/// ViewCell for a question in the user question panel.
class UserQuestionCell: UITableViewCell, UITextViewDelegate, Callback {

    @IBOutlet weak var submitButton: UIButton!
    var questionId = ""
    @IBOutlet weak var answer: UITextView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var indicatorLabel: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        submitButton.layer.cornerRadius = 5
    }

    func onResponse(request: String, responseCode: Int, response: NSDictionary) {
        if responseCode == 200 {
            setUnderReview()
        }
    }

    /// Changes the status of the question to declined.
    public func setDeclined() {
        indicatorLabel.backgroundColor = UIColor.red
        indicatorLabel.setTitle("Declined", for: .normal)
        submitButton.backgroundColor = UIColor.gray
        submitButton.setTitle("Submit New Answer", for: UIControlState.normal)
        submitButton.isEnabled = true
        answer.isEditable = true
    }

    /// Changes the status of the question to unanswered.
    public func setActive() {
        indicatorLabel.backgroundColor = UIColor.green
        indicatorLabel.setTitle("Not Answered", for: .normal)
        submitButton.backgroundColor = UIColor.gray
        submitButton.setTitle("Submit Answer", for: UIControlState.normal)
        submitButton.isEnabled = true
        answer.isEditable = true
    }

    /// Changes the status of the question to under review.
    public func setUnderReview() {
        indicatorLabel.backgroundColor = UIColor.orange
        indicatorLabel.setTitle("Under Review", for: .normal)
        submitButton.backgroundColor = UIColor.gray
        submitButton.setTitle("Under Review", for: UIControlState.normal)
        submitButton.isEnabled = false
        answer.isEditable = false
    }

    /// Sends the answer to the server running the Aldo Framework.
    @IBAction func buttonClicked(_ sender: Any) {
        Mundus.submitQuestion(callback: self, answer: answer.text, questionId: questionId)
    }
}
