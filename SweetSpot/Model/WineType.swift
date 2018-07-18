

import Foundation
import ObjectMapper



class WineType : Mappable {
var wine_type_id:Any?
var wine_type_name:Any?


required init?(map: Map){
}
func mapping(map: Map) {
wine_type_id <- map["wine_type_id"]
wine_type_name <- map["wine_type_name"]
}


func getWinetypeid()->Int{
if let val = wine_type_id as? Int{
return val
}
if let val = wine_type_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getWinetypename()->String{
if let val = wine_type_name as? String{
return val
}
else{
return ""
}//else
}//func

}




class WineTypeList : Mappable {


var winetypeList = [WineType]()

required init?(map: Map){
}


func mapping(map: Map) {
winetypeList  <- map[""]
}


}
