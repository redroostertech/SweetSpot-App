

import Foundation
import ObjectMapper



class Tannin : Mappable {
var tannin_id:Any?
var tannin_name:Any?


required init?(map: Map){
}
func mapping(map: Map) {
tannin_id <- map["tannin_id"]
tannin_name <- map["tannin_name"]
}


func getTanninid()->Int{
if let val = tannin_id as? Int{
return val
}
if let val = tannin_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getTanninname()->String{
if let val = tannin_name as? String{
return val
}
else{
return ""
}//else
}//func

}




class TanninList : Mappable {


var tanninList = [Tannin]()

required init?(map: Map){
}


func mapping(map: Map) {
tanninList  <- map[""]
}


}
