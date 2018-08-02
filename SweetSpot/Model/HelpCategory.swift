

import Foundation
import ObjectMapper



class HelpCategory : Mappable {
var help_category_id:Any?
var help_category_name:Any?


required init?(map: Map){
}
func mapping(map: Map) {
help_category_id <- map["help_category_id"]
help_category_name <- map["help_category_name"]
}


func getHelpcategoryid()->Int{
if let val = help_category_id as? Int{
return val
}
if let val = help_category_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getHelpcategoryname()->String{
if let val = help_category_name as? String{
return val
}
else{
return ""
}//else
}//func

}




class HelpCategoryList : Mappable {


var helpcategoryList = [HelpCategory]()

required init?(map: Map){
}


func mapping(map: Map) {
helpcategoryList  <- map["help_list"]
}


}
