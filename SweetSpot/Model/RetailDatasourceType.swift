

import Foundation
import ObjectMapper



class RetailDatasourceType : Mappable {
var datasource_type_id:Any?
var datasource_type_name:Any?


required init?(map: Map){
}
func mapping(map: Map) {
datasource_type_id <- map["datasource_type_id"]
datasource_type_name <- map["datasource_type_name"]
}


func getDatasourcetypeid()->Int{
if let val = datasource_type_id as? Int{
return val
}
if let val = datasource_type_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getDatasourcetypename()->String{
if let val = datasource_type_name as? String{
return val
}
else{
return ""
}//else
}//func

}




class RetailDatasourceTypeList : Mappable {


var retaildatasourcetypeList = [RetailDatasourceType]()

required init?(map: Map){
}


func mapping(map: Map) {
retaildatasourcetypeList  <- map[""]
}


}
