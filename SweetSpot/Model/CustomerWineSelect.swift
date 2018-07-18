

import Foundation
import ObjectMapper



class CustomerWineSelect : Mappable {
var customer_wine_select:Any?
var customer_id:Any?
var wine_ai_id:Any?


required init?(map: Map){
}
func mapping(map: Map) {
customer_wine_select <- map["customer_wine_select"]
customer_id <- map["customer_id"]
wine_ai_id <- map["wine_ai_id"]
}


func getCustomerwineselect()->Int{
if let val = customer_wine_select as? Int{
return val
}
if let val = customer_wine_select as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getCustomerid()->Int{
if let val = customer_id as? Int{
return val
}
if let val = customer_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getWineaiid()->Int{
if let val = wine_ai_id as? Int{
return val
}
if let val = wine_ai_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

}




class CustomerWineSelectList : Mappable {


var customerwineselectList = [CustomerWineSelect]()

required init?(map: Map){
}


func mapping(map: Map) {
customerwineselectList  <- map[""]
}


}
