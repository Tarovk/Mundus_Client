//
//  UserQuestionCell.swift
//  Mundus_ios
//
//  Created by Stephan on 11/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//

import UIKit
import Aldo

class UserQuestionCell: UITableViewCell, Callback {

    @IBOutlet weak var submitButton: UIButton!
    var questionId = ""
    @IBOutlet weak var answer: UITextView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var indicatorLabel: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        submitButton.layer.cornerRadius = 5
        // Initialization code
    }

    func onResponse(request: String, responseCode: Int, response: NSDictionary) {
        print(responseCode)
        print("jjajajaja")
        print(response)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func buttonClicked(_ sender: Any) {
        print("kilkkie")
        Requests.submitQuestion(answer: answer.text,questionId: questionId)
    }
}
