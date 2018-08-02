

import Foundation
import ObjectMapper



class WineRetailer : Mappable {
var wine_retailer_id:Any?
var wine_id:Any?
var retailer_id:Any?
var retailer_wine_name:Any?
var variety_name:Any?
var sell_by_glass:Any?
var sell_by_bottle:Any?
var retailer_price:Any?


required init?(map: Map){
}
func mapping(map: Map) {
wine_retailer_id <- map["wine_retailer_id"]
wine_id <- map["wine_id"]
retailer_id <- map["retailer_id"]
retailer_wine_name <- map["retailer_wine_name"]
variety_name <- map["variety_name"]
sell_by_glass <- map["sell_by_glass"]
sell_by_bottle <- map["sell_by_bottle"]
retailer_price <- map["retailer_price"]
}


func getWineretailerid()->Int{
if let val = wine_retailer_id as? Int{
return val
}
if let val = wine_retailer_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getWineid()->String{
if let val = wine_id as? String{
return val
}
else{
return ""
}//else
}//func

func getRetailerid()->String{
if let val = retailer_id as? String{
return val
}
else{
return ""
}//else
}//func

func getRetailerwinename()->String{
if let val = retailer_wine_name as? String{
return val
}
else{
return ""
}//else
}//func

func getVarietyname()->String{
if let val = variety_name as? String{
return val
}
else{
return ""
}//else
}//func

func getSellbyglass()->Int{
if let val = sell_by_glass as? Int{
return val
}
if let val = sell_by_glass as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getSellbybottle()->Int{
if let val = sell_by_bottle as? Int{
return val
}
if let val = sell_by_bottle as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getRetailerprice()->String{
if let val = retailer_price as? String{
return val
}
else{
return ""
}//else
}//func

}




class WineRetailerList : Mappable {


var wineretailerList = [WineRetailer]()

required init?(map: Map){
}


func mapping(map: Map) {
wineretailerList  <- map[""]
}


}
