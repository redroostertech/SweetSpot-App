

import Foundation
import ObjectMapper



class CustomerWineFavorite : Mappable {
var ss_customer_wine_favorite_id:Any?
var ss_customer_id:Any?
var ss_wine_ai_id:Any?
var cr:Any?


required init?(map: Map){
}
func mapping(map: Map) {
ss_customer_wine_favorite_id <- map["ss_customer_wine_favorite_id"]
ss_customer_id <- map["ss_customer_id"]
ss_wine_ai_id <- map["ss_wine_ai_id"]
cr <- map["cr"]
}


func getSscustomerwinefavoriteid()->Int{
if let val = ss_customer_wine_favorite_id as? Int{
return val
}
if let val = ss_customer_wine_favorite_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getSscustomerid()->Int{
if let val = ss_customer_id as? Int{
return val
}
if let val = ss_customer_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getSswineaiid()->Int{
if let val = ss_wine_ai_id as? Int{
return val
}
if let val = ss_wine_ai_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getCr()->String{
if let val = cr as? String{
return val
}
else{
return ""
}//else
}//func

}




class CustomerWineFavoriteList : Mappable {


var customerwinefavoriteList = [CustomerWineFavorite]()

required init?(map: Map){
}


func mapping(map: Map) {
customerwinefavoriteList  <- map[""]
}


}
