

import Foundation
import ObjectMapper



class WizardAnswer : Mappable {
var wizard_answer_id:Any?
var wizard_question_id:Any?
var answer_text:Any?


required init?(map: Map){
}
func mapping(map: Map) {
wizard_answer_id <- map["wizard_answer_id"]
wizard_question_id <- map["wizard_question_id"]
answer_text <- map["answer_text"]
}


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

func getAnswertext()->String{
if let val = answer_text as? String{
return val
}
else{
return ""
}//else
}//func

}




class WizardAnswerList : Mappable {


var wizardanswerList = [WizardAnswer]()

required init?(map: Map){
}


func mapping(map: Map) {
wizardanswerList  <- map[""]
}


}
