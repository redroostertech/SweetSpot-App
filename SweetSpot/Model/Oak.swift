

import Foundation
import ObjectMapper



class Oak : Mappable {
var oak_id:Any?
var oak_name:Any?


required init?(map: Map){
}
func mapping(map: Map) {
oak_id <- map["oak_id"]
oak_name <- map["oak_name"]
}


func getOakid()->Int{
if let val = oak_id as? Int{
return val
}
if let val = oak_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getOakname()->String{
if let val = oak_name as? String{
return val
}
else{
return ""
}//else
}//func

}




class OakList : Mappable {


var oakList = [Oak]()

required init?(map: Map){
}


func mapping(map: Map) {
oakList  <- map[""]
}


}
