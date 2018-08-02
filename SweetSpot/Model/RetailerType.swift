

import Foundation
import ObjectMapper



class RetailerType : Mappable {
var retailer_type_id:Any?
var retailer_type_name:Any?


required init?(map: Map){
}
func mapping(map: Map) {
retailer_type_id <- map["retailer_type_id"]
retailer_type_name <- map["retailer_type_name"]
}


func getRetailertypeid()->Int{
if let val = retailer_type_id as? Int{
return val
}
if let val = retailer_type_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getRetailertypename()->String{
if let val = retailer_type_name as? String{
return val
}
else{
return ""
}//else
}//func

}




class RetailerTypeList : Mappable {


var retailertypeList = [RetailerType]()

required init?(map: Map){
}


func mapping(map: Map) {
retailertypeList  <- map["retailer_type_list"]
}


}
