

import Foundation
import ObjectMapper



class RetailerDistance : Mappable {
var retailer_distance_id:Any?
var distance_name:Any?
var distance:Any?


required init?(map: Map){
}
func mapping(map: Map) {
retailer_distance_id <- map["retailer_distance_id"]
distance_name <- map["distance_name"]
distance <- map["distance"]
}


func getRetailerdistanceid()->Int{
if let val = retailer_distance_id as? Int{
return val
}
if let val = retailer_distance_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getDistancename()->String{
if let val = distance_name as? String{
return val
}
else{
return ""
}//else
}//func

func getDistance()->Double{
if let val = distance as? Double{
return val
}
if let val = distance as? String{
return Double(val)!
}
else{
return -1.0
}//else
}//func

}



class RetailerDistanceList : Mappable {


var retailerdistanceList = [RetailerDistance]()

required init?(map: Map){
}


func mapping(map: Map) {
retailerdistanceList  <- map["retailer_distance_list"]
}


}
