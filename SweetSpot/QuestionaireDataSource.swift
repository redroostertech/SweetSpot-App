//
//  QuestionaireDataSource.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/3/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class QuestionaireDataSource:
    NSObject
{
    
    var parent: UIViewController?
    var questions: [Question]?
    var delegate: QuestionaireDelegate?
    var selectedQuestion: Question? {
        didSet {
            guard
                let parent = self.parent as? QuestionaireViewController,
                let selectedQuestion = self.selectedQuestion
                else {
                    print("Parent has not been set")
                    return
            }
            parent.selectedQuestion = selectedQuestion
        }
    }
    
    var count = 0
    
    convenience init(parent: UIViewController){
        self.init()
        self.parent = parent
        fetchQuestionaire {
            guard let questions = self.questions else {
                return self.selectedQuestion = nil
            }
            self.selectedQuestion = questions[0]
        }
    }
    
    func fetchQuestionaire(completion: @escaping()-> Void) {
        self.questions = [Question]()
        guard let questions = sample_questionaire_date as? [[String: Any]] else {
            return completion()
        }
        for question in questions {
            let question = Question(data: question)
            self.questions?.append(question)
        }
        completion()
    }
    
    func nextQuestion() {
        guard
            let questions = self.questions,
            let selectedQuestion = self.selectedQuestion,
            let indexOfCurrentQuestion = getIndexOf(question: selectedQuestion,
                                                    inArray: questions),
            indexOfCurrentQuestion < (questions.endIndex - 1)
            else
        {
            self.delegate?.doCompleteQuestionaire()
            return print("No More Questions")
        }
        print("indexOfCurrentQuestion \(indexOfCurrentQuestion)")
        if indexOfCurrentQuestion < 1{
            self.selectedQuestion = questions[questions.index(after: indexOfCurrentQuestion)]
            hideParentPreviousButton(false)
        }else{
            //get the question
            guard
                let parent = self.parent as? QuestionaireViewController
                else {
                    print("Parent has not been set")
                    return
            }
            let selection_id = parent.selectedAnswers[0]
            let price_id = parent.selectedAnswers[1]
            
             print("selection_id \(selection_id)")
            print("price_id \(price_id)")
            let parameters: Parameters = ["action": "getFinalQuestionChoices",
                                          "color_id": "\(selection_id)",
                                         
                "price_id":"\(price_id)"
            ]
            Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseString { response in
                print(response.result.value!)
                do{
                    let data = response.result.value!.data(using: .utf8)!
                    let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String: Any]
                    self.selectedQuestion = Question(data: jsonArray!)
                    self.hideParentPreviousButton(false)
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
    
    func getPriceIDFromSelection(selection:Int)->Int{
        var price_id =  0
        switch(selection){
        case 0:
            price_id = 6
            break
        case 1:
            price_id = 7
            break
        case 2:
            price_id = 8
            break
        case 3:
            price_id = 9
            break
        case 4:
            price_id = 10
            break
        default:
            break
        }
        return price_id
    }
    
    func previous() {
        guard
            let questions = self.questions,
            let selectedQuestion = self.selectedQuestion,
            let indexOfCurrentQuestion = getIndexOf(question: selectedQuestion,
                                                    inArray: questions),
            indexOfCurrentQuestion > questions.startIndex
            else {
                return print("No More Questions")
        }
        self.selectedQuestion = questions[questions.index(before: indexOfCurrentQuestion)]
        
        if questions.index(before: indexOfCurrentQuestion) == 0 {
            self.hideParentPreviousButton(true)
        }
    }
    
    func hideParentPreviousButton(_ hide: Bool) {
        guard
            let parent = self.parent as? QuestionaireViewController
            else {
                print("Parent has not been set")
                return
        }
        switch hide {
        case true:
            parent.btn_Previous.isHidden = true
        case false:
            parent.btn_Previous.isHidden = false
        }
    }
    
    func getIndexOf(question: Question, inArray questions: [Question]) -> Int? {
        if let index = questions.index(where: {
            (item) -> Bool in
            item.title == question.title
        }) {
            return index
        } else {
            return nil
        }
    }
    
}
