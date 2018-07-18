

import Foundation
import ObjectMapper



class WizardCustomerAnswer : Mappable {
var wizard_customer_answer_id:Any?
var customer_id:Any?
var wizard_question_id:Any?
var wizard_answer_id:Any?


required init?(map: Map){
}
func mapping(map: Map) {
wizard_customer_answer_id <- map["wizard_customer_answer_id"]
customer_id <- map["customer_id"]
wizard_question_id <- map["wizard_question_id"]
wizard_answer_id <- map["wizard_answer_id"]
}


func getWizardcustomeranswerid()->Int{
if let val = wizard_customer_answer_id as? Int{
return val
}
if let val = wizard_customer_answer_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getCustomerid()->Int{
if let val = customer_id as? Int{
return val
}
if let val = customer_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getWizardquestionid()->Int{
if let val = wizard_question_id as? Int{
return val
}
if let val = wizard_question_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getWizardanswerid()->Int{
if let val = wizard_answer_id as? Int{
return val
}
if let val = wizard_answer_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

}




class WizardCustomerAnswerList : Mappable {


var wizardcustomeranswerList = [WizardCustomerAnswer]()

required init?(map: Map){
}


func mapping(map: Map) {
wizardcustomeranswerList  <- map[""]
}


}
