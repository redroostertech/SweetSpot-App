//
//  QuestionaireViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 6/30/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

let sample_questionaire_date = [
    ["title": "First Question...",
     "question": "Do you enjoy white or red wines more frequently?",
     "responses": [["response_text":"Only White", "response_id":1],
                   ["response_text":"Mostly White","response_id":2],
                   ["response_text":"Half White Half Red","response_id":3],
                   ["response_text":"Mostly Red","response_id":4],
                   ["response_text":"Only Red","response_id":5]]
    ],
    ["title": "Second Question...",
     "question": "What is your preferred price for a bottle of wine in a retail store?",
     "responses": [["response_text":"< $6", "response_id":6],
                   ["response_text":"$6 - $9.99","response_id":7],
                   ["response_text":"$10 - $14.99","response_id":8],
                   ["response_text":"$15 - $24.99","response_id":9],
                    ["response_text":"> $25","response_id":10]]
    ],
    ["title": "Third Question...",
     "question": "Which of these wines are your most likely to purchase?",
     "responses": ["Kendall - Jackson Vintners Reserver",
                   "Louis Latour Grand Ardeche Chardonnay",
                   "Not Sure"]
    ]
]

class QuestionaireViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource,
    QuestionaireDelegate,
    QuestionCellDelegate
{

    @IBOutlet var lbl_TitleOfView: UILabel!
    @IBOutlet var lbl_QuestionTitle: UILabel!
    @IBOutlet var lbl_Question: UILabel!
    @IBOutlet var questionaireTable: UITableView!
    @IBOutlet var btn_Next: UIButton!
    @IBOutlet var btn_Previous: UIButton!
    @IBOutlet var btn_GoBack: UIButton!
    @IBOutlet var titleViewConstraint: NSLayoutConstraint!
    
    var startingViewController: Any?
    var user: User!
    var selectedQuestion: Question? {
        didSet {
            guard
                let selectedQuestion = selectedQuestion
                else {
                    print("Question title has not been set")
                    return
            }
            self.lbl_QuestionTitle.text = selectedQuestion.title ?? ""
            self.lbl_Question.text = selectedQuestion.question ?? ""
            self.questionaireTable.reloadData()
        }
    }
   
    var questionaireDataSource: QuestionaireDataSource!
    var selectedAnswers = [Int](repeating: -1, count: 4)
    var currentQuestionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.AppColors.purple
        lbl_TitleOfView.textColor = UIColor.AppColors.beige
        lbl_TitleOfView.text = questionaire_title.uppercased()
        lbl_QuestionTitle.textColor = UIColor.AppColors.beige
        lbl_Question.textColor = UIColor.AppColors.beige
        
        btn_Next.layer.cornerRadius = CGFloat(btn_radius)
        btn_Next.layer.borderColor = UIColor.AppColors.black.cgColor
        btn_Next.layer.borderWidth = CGFloat(btn_border_width)
        btn_Next.backgroundColor = UIColor.AppColors.beige
        btn_Next.setTitleColor(UIColor.AppColors.black,
                               for: .normal)
        btn_Next.setTitle(registration_next
            .uppercased(),
                          for: .normal)
        
        btn_Previous.layer.cornerRadius = CGFloat(btn_radius)
        btn_Previous.layer.borderColor = UIColor.AppColors.beige.cgColor
        btn_Previous.layer.borderWidth = CGFloat(btn_border_width)
        btn_Previous.backgroundColor = UIColor.clear
        btn_Previous.setTitleColor(UIColor.AppColors.beige,
                                 for: .normal)
        btn_Previous.setTitle(registration_previous.uppercased(),
                            for: .normal)
        btn_Previous.isHidden = true
        
        self.questionaireDataSource = QuestionaireDataSource(parent: self)
        self.questionaireDataSource.delegate = self
        
        questionaireTable.delegate = self
        questionaireTable.dataSource = self
        questionaireTable.backgroundColor = .clear
        let questionaireNib = UINib(nibName: "QuestionaireTableViewCell",
                                    bundle: nil)
        questionaireTable.register(questionaireNib,
                                   forCellReuseIdentifier: "QuestionaireTableViewCell")
        questionaireTable.reloadData()
        
        if let _ = self.startingViewController as? RegistrationViewController {
            self.btn_GoBack.isHidden = true
            self.titleViewConstraint.constant = 16
        } else {
            self.btn_GoBack.isHidden = false
            self.titleViewConstraint.constant = 66
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true,
                completion: nil)
    }
    
    @IBAction func next(_ sender: UIButton) {
        //get selected
       
        currentQuestionIndex = currentQuestionIndex + 1
        print("currentQuestionIndex: \(currentQuestionIndex) and selectedAnswer: \(selectedAnswers[currentQuestionIndex -  1])")
        if currentQuestionIndex == 2 && selectedAnswers[1] == 0{
            doCompleteQuestionaire()
        }else{
            if selectedAnswers[currentQuestionIndex -  1] > -1{
                self.questionaireDataSource.nextQuestion()
            }else{
                showError(message: "You must select one of the options")
                currentQuestionIndex = currentQuestionIndex - 1
            }
        }
    }
    func showError(message:String){
        let alertView = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in })
        alertView.addAction(okAction)
        self.show(alertView, sender: self)
    }
    @IBAction func previous(_ sender: UIButton) {
        self.questionaireDataSource.previous()
        currentQuestionIndex = currentQuestionIndex - 1
    }
    
    func doCompleteQuestionaire() {
        
        print("selectedAnswers: \(selectedAnswers)")
        
        let parameters: Parameters = ["action": "updateUserWineProfile",
                                      "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID"),
                                      "color_id":"\(selectedAnswers[0])",
                                      "price_id":"\(selectedAnswers[1])",
                                      "wine_name_id":"\(selectedAnswers[2])"
                                     
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseString { response in
            let sb = UIStoryboard(name: "Main",
                                  bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "QuestionaireFinalStepViewController") as? QuestionaireFinalStepViewController else {
                return
            }
            vc.user = self.user
            
            self.present(vc,
                         animated: true,
                         completion: nil)
        }
        
        
    }
    
    func doSend(selection: Any, fromCell cell: UITableViewCell) {
        guard let cell = cell as? QuestionaireTableViewCell else {
            return
        }
        let selectedImg = UIImage(named: "group")
        cell.btn_Selection.setImage(selectedImg,
                                    for: .normal)
        let totalRows = self.questionaireTable.numberOfRows(inSection: 0)
        for row in 0...totalRows {
            let refCellIndexPath = IndexPath(row: row,
                                             section: 0)
            if
                let refCell = self.questionaireTable.cellForRow(at: refCellIndexPath) as? QuestionaireTableViewCell,
                refCell != cell
            {
                let selectedImg = UIImage(named: "oval")
                refCell.btn_Selection.setImage(selectedImg,
                                               for: .normal)
            }else{
                if row < totalRows {
                    selectedAnswers[currentQuestionIndex] = cell.tag
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard
            let selectedQuestion = self.selectedQuestion,
            let selectedQuestionResponses = selectedQuestion.responses else {
                return 7
        }
        return selectedQuestionResponses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionaireTableViewCell",
                                                       for: indexPath) as? QuestionaireTableViewCell else {
                                                        return UITableViewCell()
        }
        let selectedImg = UIImage(named: "oval")
        cell.btn_Selection.setImage(selectedImg,
                                    for: .normal)
        //cell.tag = indexPath.row
        cell.selectionStyle = .none
        cell.questionaireDelegate = self
        if
            let selectedQuestion = self.selectedQuestion,
            let selectedQuestionResponses = selectedQuestion.responses
        {
            let item = selectedQuestionResponses[indexPath.row]
            cell.lbl_Response.text = item.response_text
            cell.tag = item.response_id
        }
        return cell
    }
    
}


