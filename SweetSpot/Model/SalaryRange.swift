

import Foundation
import ObjectMapper



class SalaryRange : Mappable {
var salary_range_id:Any?
var salary_range_name:Any?


required init?(map: Map){
}
func mapping(map: Map) {
salary_range_id <- map["salary_range_id"]
salary_range_name <- map["salary_range_name"]
}


func getSalaryrangeid()->Int{
if let val = salary_range_id as? Int{
return val
}
if let val = salary_range_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getSalaryrangename()->String{
if let val = salary_range_name as? String{
return val
}
else{
return ""
}//else
}//func

}




class SalaryRangeList : Mappable {


var salaryrangeList = [SalaryRange]()

required init?(map: Map){
}


func mapping(map: Map) {
salaryrangeList  <- map["salary_list"]
}


}
