

import Foundation
import ObjectMapper



class WizardAnswerMatrix : Mappable {
var wizard_answer_matrix_id:Any?
var color_id:Any?
var price_id:Any?
var wine_name_id:Any?
var wine_profile_id:Any?


required init?(map: Map){
}
func mapping(map: Map) {
wizard_answer_matrix_id <- map["wizard_answer_matrix_id"]
color_id <- map["color_id"]
price_id <- map["price_id"]
wine_name_id <- map["wine_name_id"]
wine_profile_id <- map["wine_profile_id"]
}


func getWizardanswermatrixid()->Int{
if let val = wizard_answer_matrix_id as? Int{
return val
}
if let val = wizard_answer_matrix_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getColorid()->Int{
if let val = color_id as? Int{
return val
}
if let val = color_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getPriceid()->Int{
if let val = price_id as? Int{
return val
}
if let val = price_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getWinenameid()->Int{
if let val = wine_name_id as? Int{
return val
}
if let val = wine_name_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getWineprofileid()->Int{
if let val = wine_profile_id as? Int{
return val
}
if let val = wine_profile_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

}




class WizardAnswerMatrixList : Mappable {


var wizardanswermatrixList = [WizardAnswerMatrix]()

required init?(map: Map){
}


func mapping(map: Map) {
wizardanswermatrixList  <- map[""]
}


}
