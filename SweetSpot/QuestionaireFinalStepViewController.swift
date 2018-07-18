//
//  QuestionaireFinalStepViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 6/30/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire


class QuestionaireFinalStepViewController: UIViewController {
    
    @IBOutlet var lbl_TitleOfView: UILabel!
    @IBOutlet var lbl_Header: UILabel!
    @IBOutlet var btn_Finished: UIButton!
    @IBOutlet var btn_Skip: UIButton!
    @IBOutlet var lbl_MaritalStatus: UILabel!
    @IBOutlet var lbl_Age: UILabel!
    @IBOutlet var lbl_Salary: UILabel!
    @IBOutlet var lbl_Gender: UILabel!
    @IBOutlet var text_MaritalStatus: UITextField!
    @IBOutlet var text_Age: UITextField!
    @IBOutlet var text_Salary: UITextField!
    @IBOutlet var text_Gender: UITextField!
    
    
    var picker: UIPickerView?
    var user: User!
    var dropDownType: Int = 0
    var salaryList:SalaryRangeList = SalaryRangeList(JSONString: "{}")!
    var genderList:GenderList = GenderList(JSONString: "{}")!
    var ageRangeList:AgeRangeList = AgeRangeList(JSONString: "{}")!
    var maritalStatusList:MaritalStatusList = MaritalStatusList(JSONString: "{}")!
    
    var selectedSalary = 0
    var selectedGender = 0
    var selectedAge = 0
    var selectedMarital = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text_Age.delegate = self
        text_Gender.delegate = self
        text_Salary.delegate = self
        text_MaritalStatus.delegate = self
        
        self.view.backgroundColor = UIColor.AppColors.purple
        
        
        lbl_TitleOfView.textColor = UIColor.AppColors.beige
        lbl_TitleOfView.text = questionaire_title.uppercased()
        lbl_Header.textColor = UIColor.AppColors.beige
        
        lbl_TitleOfView.textColor = UIColor.AppColors.beige
        
        btn_Finished.layer.cornerRadius = CGFloat(btn_radius)
        btn_Finished.layer.borderColor = UIColor.AppColors.black.cgColor
        btn_Finished.layer.borderWidth = CGFloat(btn_border_width)
        btn_Finished.backgroundColor = UIColor.AppColors.beige
        btn_Finished.setTitleColor(UIColor.AppColors.black,
                                   for: .normal)
        btn_Finished.setTitle(registration_finished
            .uppercased(),
                              for: .normal)
        
        btn_Skip.layer.cornerRadius = CGFloat(btn_radius)
        btn_Skip.layer.borderColor = UIColor.AppColors.beige.cgColor
        btn_Skip.layer.borderWidth = CGFloat(btn_border_width)
        btn_Skip.backgroundColor = UIColor.clear
        btn_Skip.setTitleColor(UIColor.AppColors.beige,
                               for: .normal)
        btn_Skip.setTitle(registration_skip.uppercased(),
                          for: .normal)
        
        for i in 1...5{
            loadList(list_id: i)
        }
        
        self.text_Salary.text = ""
        self.text_Age.text = ""
        self.text_MaritalStatus.text = ""
        self.text_Gender.text = ""
    }
    
    func loadList(list_id:Int){
        var action = ""
        switch(list_id){
        case 1:
            action = "getGenders"
            break
        case 2:
            action = "getMaritalStatuses"
            break
        case 3:
            action = "getAgeRanges"
            break
        case 4:
            action = "getSalaryRanges"
            break
        default:
            break
        }
        let parameters: Parameters = ["action": action]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseString { response in
            print("Response: \(response.result.value!)")
            switch(list_id){
            case 1:
                self.genderList = GenderList(JSONString: response.result.value!)!
                break
            case 2:
                self.maritalStatusList = MaritalStatusList(JSONString: response.result.value!)!
                break
            case 3:
                self.ageRangeList = AgeRangeList(JSONString: response.result.value!)!
                break
            case 4:
                self.salaryList = SalaryRangeList(JSONString: response.result.value!)!
                break
            default:
                break
            }
            
            
        } //alamofire
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func finished(_ sender: UIButton) {
        
        let parameters: Parameters = ["action": "updateUserProfile",
                                      "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID"),
                                      "gender_id":"\(selectedGender)",
                                      "marital_status_id":"\(selectedMarital)",
                                      "salary_range_id":"\(selectedSalary)",
                                      "age_range_id":"\(selectedAge)"
            
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseString { response in
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
    
    @IBAction func skip(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main",
                              bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController else {
            return
        }
        vc.user = self.user
        self.present(vc,
                     animated: true,
                     completion: nil)
    }
    
    func presentPicker(_ textField: UITextField) {
        self.picker = UIPickerView()
        self.picker?.delegate = self
        self.picker?.dataSource = self
        self.picker?.reloadAllComponents()
        textField.inputView = self.picker
    }
}

extension QuestionaireFinalStepViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case text_MaritalStatus:
            self.presentPicker(textField)
            self.dropDownType = 2
        case text_Age:
            self.dropDownType = 3
            self.presentPicker(textField)
        case text_Salary:
            self.dropDownType = 4
            self.presentPicker(textField)
        case text_Gender:
            self.dropDownType = 1
            self.presentPicker(textField)
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



extension QuestionaireFinalStepViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        let dropDownType = self.dropDownType
        switch(dropDownType){
        case 1:
            return genderList.genderList.count
            
        case 2:
            return maritalStatusList.maritalstatusList.count
            
        case 3:
            return ageRangeList.agerangeList.count
            
        case 4:
            return salaryList.salaryrangeList.count
            
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch(dropDownType){
        case 1:
            return genderList.genderList[row].getGendername()
            
        case 2:
            return maritalStatusList.maritalstatusList[row].getMaritalstatusname()
            
        case 3:
            return ageRangeList.agerangeList[row].getAgerangename()
            
        case 4:
            return salaryList.salaryrangeList[row].getSalaryrangename()
            
        default:
            return ""
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //find the object at row and set the corresponding variable value (marital = 1, gender = 1, etc...)
        switch(dropDownType){
        case 1:
            self.selectedGender = genderList.genderList[row].getGenderid()
            self.text_Gender.text = genderList.genderList[row].getGendername()
            break
        case 2:
            self.selectedMarital = maritalStatusList.maritalstatusList[row].getMaritalstatusid()
            self.text_MaritalStatus.text = maritalStatusList.maritalstatusList[row].getMaritalstatusname()
            break
        case 3:
            self.selectedAge = ageRangeList.agerangeList[row].getAgerangeid()
            self.text_Age.text = ageRangeList.agerangeList[row].getAgerangename()
            break
        case 4:
            self.selectedSalary = salaryList.salaryrangeList[row].getSalaryrangeid()
            self.text_Salary.text = salaryList.salaryrangeList[row].getSalaryrangename()
            break
        default:
            break
        }
    }
    
}


