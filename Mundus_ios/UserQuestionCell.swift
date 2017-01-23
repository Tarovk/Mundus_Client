//
//  UserQuestionCell.swift
//  Mundus_ios
//
//  Created by Stephan on 11/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//

import UIKit
import Aldo
import Alamofire

class UserQuestionCell: UITableViewCell, Callback {

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

    public func setDeclined() {
        indicatorLabel.backgroundColor = UIColor.red
        indicatorLabel.setTitle("Declined", for: .normal)
        submitButton.backgroundColor = UIColor.gray
        submitButton.setTitle("Submit New Answer", for: UIControlState.normal)
        submitButton.isEnabled = true
        answer.isEditable = true
    }

    public func setActive() {
        indicatorLabel.backgroundColor = UIColor.green
        indicatorLabel.setTitle("Not Answered", for: .normal)
        submitButton.backgroundColor = UIColor.gray
        submitButton.setTitle("Submit Answer", for: UIControlState.normal)
        submitButton.isEnabled = true
        answer.isEditable = true
    }

    public func setUnderReview() {
        indicatorLabel.backgroundColor = UIColor.orange
        indicatorLabel.setTitle("Under Review", for: .normal)
        submitButton.backgroundColor = UIColor.gray
        submitButton.setTitle("Under Review", for: UIControlState.normal)
        submitButton.isEnabled = false
        answer.isEditable = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func buttonClicked(_ sender: Any) {
        Mundus.submitQuestion(callback: self, answer: answer.text,questionId: questionId)
    }
}
