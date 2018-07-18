

import Foundation
import ObjectMapper



class WineProfile : Mappable {
var wine_profile_id:Any?
var wine_profile_name:Any?


required init?(map: Map){
}
func mapping(map: Map) {
wine_profile_id <- map["wine_profile_id"]
wine_profile_name <- map["wine_profile_name"]
}


func getWineprofileid()->Int{
if let val = wine_profile_id as? Int{
return val
}
if let val = wine_profile_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getWineprofilename()->String{
if let val = wine_profile_name as? String{
return val
}
else{
return ""
}//else
}//func

}




class WineProfileList : Mappable {


var wineprofileList = [WineProfile]()

required init?(map: Map){
}


func mapping(map: Map) {
wineprofileList  <- map[""]
}


}
