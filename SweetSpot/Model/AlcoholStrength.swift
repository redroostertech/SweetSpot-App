

import Foundation
import ObjectMapper



class AlcoholStrength : Mappable {
var alcohol_strength_id:Any?
var alcohol_strength_name:Any?


required init?(map: Map){
}
func mapping(map: Map) {
alcohol_strength_id <- map["alcohol_strength_id"]
alcohol_strength_name <- map["alcohol_strength_name"]
}


func getAlcoholstrengthid()->Int{
if let val = alcohol_strength_id as? Int{
return val
}
if let val = alcohol_strength_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getAlcoholstrengthname()->String{
if let val = alcohol_strength_name as? String{
return val
}
else{
return ""
}//else
}//func

}




class AlcoholStrengthList : Mappable {


var alcoholstrengthList = [AlcoholStrength]()

required init?(map: Map){
}


func mapping(map: Map) {
alcoholstrengthList  <- map[""]
}


}
