

import Foundation
import ObjectMapper



class MaritalStatus : Mappable {
var marital_status_id:Any?
var marital_status_name:Any?


required init?(map: Map){
}
func mapping(map: Map) {
marital_status_id <- map["marital_status_id"]
marital_status_name <- map["marital_status_name"]
}


func getMaritalstatusid()->Int{
if let val = marital_status_id as? Int{
return val
}
if let val = marital_status_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getMaritalstatusname()->String{
if let val = marital_status_name as? String{
return val
}
else{
return ""
}//else
}//func

}




class MaritalStatusList : Mappable {


var maritalstatusList = [MaritalStatus]()

required init?(map: Map){
}


func mapping(map: Map) {
maritalstatusList  <- map["marital_list"]
}


}
