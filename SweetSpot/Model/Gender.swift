

import Foundation
import ObjectMapper



class Gender : Mappable {
var gender_id:Any?
var gender_name:Any?


required init?(map: Map){
}
func mapping(map: Map) {
gender_id <- map["gender_id"]
gender_name <- map["gender_name"]
}


func getGenderid()->Int{
if let val = gender_id as? Int{
return val
}
if let val = gender_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getGendername()->String{
if let val = gender_name as? String{
return val
}
else{
return ""
}//else
}//func

}




class GenderList : Mappable {


var genderList = [Gender]()

required init?(map: Map){
}


func mapping(map: Map) {
genderList  <- map["gender_list"]
}


}
