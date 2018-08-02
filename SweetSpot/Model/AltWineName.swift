

import Foundation
import ObjectMapper



class AltWineName : Mappable {
var alt_wine_name_id:Any?
var wine_id:Any?
var alt_wine_name:Any?


required init?(map: Map){
}
func mapping(map: Map) {
alt_wine_name_id <- map["alt_wine_name_id"]
wine_id <- map["wine_id"]
alt_wine_name <- map["alt_wine_name"]
}


func getAltwinenameid()->Int{
if let val = alt_wine_name_id as? Int{
return val
}
if let val = alt_wine_name_id as? String{
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

func getAltwinename()->String{
if let val = alt_wine_name as? String{
return val
}
else{
return ""
}//else
}//func

}




class AltWineNameList : Mappable {


var altwinenameList = [AltWineName]()

required init?(map: Map){
}


func mapping(map: Map) {
altwinenameList  <- map[""]
}


}
