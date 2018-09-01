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
        
        questionaireTable.reloadData()
        
        if let _ = self.startingViewController as? RegistrationViewController {
            self.btn_GoBack.isHidden = true
            self.titleViewConstraint.constant = 16
        } else {
            self.btn_GoBack.isHidden = false
            self.titleViewConstraint.constant = 66
        }
        
        SSAnalytics.reportUserAction(action_type: SSAnalytics.AnalyticsActionType.QUESTION_ONE)
      
    }
    
   
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true,
                completion: nil)
    }
    
    @IBAction func next(_ sender: UIButton) {
        //get selected
       
        if currentQuestionIndex == 1 {
            SSAnalytics.reportUserAction(action_type: SSAnalytics.AnalyticsActionType.QUESTION_TWO)
        }else{
            SSAnalytics.reportUserAction(action_type: SSAnalytics.AnalyticsActionType.QUESTION_THREE)
        }
        
        currentQuestionIndex = currentQuestionIndex + 1
        print("currentQuestionIndex: \(currentQuestionIndex) and selectedAnswer: \(selectedAnswers[currentQuestionIndex -  1])")
        if (currentQuestionIndex == 2 && selectedAnswers[1] == 6) || (currentQuestionIndex == 2 && selectedAnswers[1] == 7){
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
            
            if Utils().getPermanentString(keyName: "IS_ONBOARDED") == "" {
            let sb = UIStoryboard(name: "Main",
                                  bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "QuestionaireFinalStepViewController") as? QuestionaireFinalStepViewController else {
                return
            }
            vc.user = self.user
            
            self.present(vc,
                         animated: true,
                         completion: nil)
            }else{
                let sb = UIStoryboard(name: "Main",
                                      bundle: nil)
                guard let vc = sb.instantiateViewController(withIdentifier: "RegistrationCompletionViewController") as? RegistrationCompletionViewController else {
                    return
                }
                vc.user = self.user
                self.present(vc,
                             animated: true,
                             completion: nil)
            }
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
        tableView.register(QuestionaireTableViewCell.self, forCellReuseIdentifier: "QuestionaireTableViewCell")
         tableView.register(UINib(nibName: "QuestionaireTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionaireTableViewCell")
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


