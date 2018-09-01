

import Foundation
import ObjectMapper



class Retailer : Mappable {
    var retailer_ai_id:Any?
    var retailer_id:Any?
    var retailer_type_id:Any?
    var retailer_last_update:Any?
    var wine_list_refresh_frequency:Any?
    var wine_list_refresh_date:Any?
    var retailer_group:Any?
    var retailer_name:Any?
    var retailer_location:Any?
    var retailer_image_url:Any?
    var address_line_1:Any?
    var address_line_2:Any?
    var city:Any?
    var state:Any?
    var zip_code:Any?
    var phone:Any?
    var retailer_latitude:Any?
    var retailer_longitude:Any?
    var retailer_url:Any?
    var datasource_type_id:Any?
    var datasource_url:Any?
    var sell_by_glass:Any?
    var sell_by_bottle:Any?
    var retailer_multiple:Any?
    var date_entered:Any?
    var date_updated:Any?
    var is_active:Any?
    
    var distance:String?
    
    required init?(map: Map){
    }
    func mapping(map: Map) {
        retailer_ai_id <- map["retailer_ai_id"]
        retailer_id <- map["retailer_id"]
        retailer_type_id <- map["retailer_type_id"]
        retailer_last_update <- map["retailer_last_update"]
        wine_list_refresh_frequency <- map["wine_list_refresh_frequency"]
        wine_list_refresh_date <- map["wine_list_refresh_date"]
        retailer_group <- map["retailer_group"]
        retailer_name <- map["retailer_name"]
        retailer_location <- map["retailer_location"]
        retailer_image_url <- map["retailer_image_url"]
        address_line_1 <- map["address_line_1"]
        address_line_2 <- map["address_line_2"]
        city <- map["city"]
        state <- map["state"]
        zip_code <- map["zip_code"]
        phone <- map["phone"]
        retailer_latitude <- map["retailer_latitude"]
        retailer_longitude <- map["retailer_longitude"]
        retailer_url <- map["retailer_url"]
        datasource_type_id <- map["datasource_type_id"]
        datasource_url <- map["datasource_url"]
        sell_by_glass <- map["sell_by_glass"]
        sell_by_bottle <- map["sell_by_bottle"]
        retailer_multiple <- map["retailer_multiple"]
        date_entered <- map["date_entered"]
        date_updated <- map["date_updated"]
        is_active <- map["is_active"]
        distance <- map["distance"]
    }
    
    
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
    
    func getRetailerid()->String{
        if let val = retailer_id as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getRetailertypeid()->Int{
        if let val = retailer_type_id as? Int{
            return val
        }
        if let val = retailer_type_id as? String{
            return Int(val)!
        }
        else{
            return -1
        }//else
    }//func
    
    func getRetailerlastupdate()->String{
        if let val = retailer_last_update as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getWinelistrefreshfrequency()->Int{
        if let val = wine_list_refresh_frequency as? Int{
            return val
        }
        if let val = wine_list_refresh_frequency as? String{
            return Int(val)!
        }
        else{
            return -1
        }//else
    }//func
    
    func getWinelistrefreshdate()->String{
        if let val = wine_list_refresh_date as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getRetailergroup()->String{
        if let val = retailer_group as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getRetailername()->String{
        if let val = retailer_name as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getRetailerlocation()->String{
        if let val = retailer_location as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    func getRetailerimageurl()->String{
        if let val = retailer_image_url as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    func getAddressline1()->String{
        if let val = address_line_1 as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getAddressline2()->String{
        if let val = address_line_2 as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getCity()->String{
        if let val = city as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getState()->String{
        if let val = state as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getZipcode()->Int{
        if let val = zip_code as? Int{
            return val
        }
        if let val = zip_code as? String{
            return Int(val)!
        }
        else{
            return -1
        }//else
    }//func
    
    func getPhone()->String{
        if let val = phone as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getRetailerlatitude()->String{
        if let val = retailer_latitude as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getRetailerlongitude()->String{
        if let val = retailer_longitude as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getRetailerurl()->String{
        if let val = retailer_url as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getDatasourcetypeid()->Int{
        if let val = datasource_type_id as? Int{
            return val
        }
        if let val = datasource_type_id as? String{
            return Int(val)!
        }
        else{
            return -1
        }//else
    }//func
    
    func getDatasourceurl()->String{
        if let val = datasource_url as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getSellbyglass()->String{
        if let val = sell_by_glass as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getSellbybottle()->String{
        if let val = sell_by_bottle as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getRetailermultiple()->Double{
        if let val = retailer_multiple as? Double{
            return val
        }
        if let val = retailer_multiple as? String{
            return Double(val)!
        }
        else{
            return -1.0
        }//else
    }//func
    
    func getDateentered()->String{
        if let val = date_entered as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getDateupdated()->Int{
        if let val = date_updated as? Int{
            return val
        }
        if let val = date_updated as? String{
            return Int(val)!
        }
        else{
            return -1
        }//else
    }//func
    
    func getIsactive()->String{
        if let val = is_active as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
}




class RetailerList : Mappable {
    
    
    var retailerList = [Retailer]()
    
    required init?(map: Map){
    }
    
    
    func mapping(map: Map) {
        retailerList  <- map["retail_list"]
    }
    
    
}
