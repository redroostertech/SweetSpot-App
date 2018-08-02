

import Foundation
import ObjectMapper



class WineColor : Mappable {
var wine_color_id:Any?
var wine_color_name:Any?


required init?(map: Map){
}
func mapping(map: Map) {
wine_color_id <- map["wine_color_id"]
wine_color_name <- map["wine_color_name"]
}


func getWinecolorid()->Int{
if let val = wine_color_id as? Int{
return val
}
if let val = wine_color_id as? String{
return Int(val)!
}
else{
return -1
}//else
}//func

func getWinecolorname()->String{
if let val = wine_color_name as? String{
return val
}
else{
return ""
}//else
}//func

}




class WineColorList : Mappable {


var winecolorList = [WineColor]()

required init?(map: Map){
}


func mapping(map: Map) {
winecolorList  <- map[""]
}


}
