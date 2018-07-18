

import Foundation
import ObjectMapper



class Acidity : Mappable {
var acidity_id:Any?
var acidity_name:Any?


required init?(map: Map){
}
func mapping(map: Map) {
acidity_id <- map["acidity_id"]
acidity_name <- map["acidity_name"]
}


func getAcidityid()->Int{
if let val = acidity_id as? Int{
return val
}
if let val = acidity_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getAcidityname()->String{
if let val = acidity_name as? String{
return val
}
else{
return ""
}//else
}//func

}




class AcidityList : Mappable {


var acidityList = [Acidity]()

required init?(map: Map){
}


func mapping(map: Map) {
acidityList  <- map[""]
}


}
