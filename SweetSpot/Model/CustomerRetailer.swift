

import Foundation
import ObjectMapper



class CustomerRetailer : Mappable {
var customer_retailer_id:Any?
var customer_id:Any?
var retailer_ai_id:Any?
var visit_count:Any?
var last_visit_date:Any?
var first_visit_date:Any?


required init?(map: Map){
}
func mapping(map: Map) {
customer_retailer_id <- map["customer_retailer_id"]
customer_id <- map["customer_id"]
retailer_ai_id <- map["retailer_ai_id"]
visit_count <- map["visit_count"]
last_visit_date <- map["last_visit_date"]
first_visit_date <- map["first_visit_date"]
}


func getCustomerretailerid()->Int{
if let val = customer_retailer_id as? Int{
return val
}
if let val = customer_retailer_id as? String{
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

func getRetaileraiid()->Int{
if let val = retailer_ai_id as? Int{
return val
}
if let val = retailer_ai_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getVisitcount()->Int{
if let val = visit_count as? Int{
return val
}
if let val = visit_count as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getLastvisitdate()->String{
if let val = last_visit_date as? String{
return val
}
else{
return ""
}//else
}//func

func getFirstvisitdate()->String{
if let val = first_visit_date as? String{
return val
}
else{
return ""
}//else
}//func

}




class CustomerRetailerList : Mappable {


var customerretailerList = [CustomerRetailer]()

required init?(map: Map){
}


func mapping(map: Map) {
customerretailerList  <- map[""]
}


}
