

import Foundation
import ObjectMapper



class AgeRange : Mappable {
var age_range_id:Any?
var age_range_name:Any?


required init?(map: Map){
}
func mapping(map: Map) {
age_range_id <- map["age_range_id"]
age_range_name <- map["age_range_name"]
}


func getAgerangeid()->Int{
if let val = age_range_id as? Int{
return val
}
if let val = age_range_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getAgerangename()->String{
if let val = age_range_name as? String{
return val
}
else{
return ""
}//else
}//func

}




class AgeRangeList : Mappable {


var agerangeList = [AgeRange]()

required init?(map: Map){
}


func mapping(map: Map) {
agerangeList  <- map["age_list"]
}


}
