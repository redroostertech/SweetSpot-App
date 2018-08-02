//
//  Question.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/3/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import Foundation

protocol QuestionaireDelegate {
    func doCompleteQuestionaire()
}

struct Question {
    var title: String?
    var question: String?
    var responses: [QuestionResponse]?
    
    init(data: [String: Any]) {
        self.title = data["title"] as? String ?? nil
        self.question = data["question"] as? String ?? nil
        if let responseArray = data["responses"] as? [[String: Any]] {
            self.responses = [QuestionResponse]()
            for response in responseArray {
                print("\(response)")
                let res = QuestionResponse(response: response["response_text"] as! String, response_id: response["response_id"] as! Int)
                self.responses?.append(res)
            }
        } else {
            self.responses = nil
        }
    }
    
}

struct QuestionResponse {
    var response_text: String
    var response_id: Int
    init(response: String, response_id: Int) {
        self.response_text = response
        self.response_id = response_id
        
    }
}
