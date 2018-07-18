

import Foundation
import ObjectMapper



class WizardQuestion : Mappable {
var wizard_question_id:Any?
var question_text:Any?


required init?(map: Map){
}
func mapping(map: Map) {
wizard_question_id <- map["wizard_question_id"]
question_text <- map["question_text"]
}


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

func getQuestiontext()->String{
if let val = question_text as? String{
return val
}
else{
return ""
}//else
}//func

}




class WizardQuestionList : Mappable {


var wizardquestionList = [WizardQuestion]()

required init?(map: Map){
}


func mapping(map: Map) {
wizardquestionList  <- map[""]
}


}
