

import Foundation
import ObjectMapper



class Wine : Mappable {
    var wine_ai_id:Any?
    var wine_id:Any?
    var retailer_id:Any?
    var wine_name:Any?
    var wine_description:Any?
    var winery_name:Any?
    var wine_profile_id:Any?
    var wine_stretch_id:Any?
    var variety_name:Any?
    var winery_url:Any?
    var photo_url:Any?
    var country:Any?
    var state:Any?
    var region:Any?
    var subregion:Any?
    var vineyard:Any?
    var wine_color_id:Any?
    var wine_type_id:Any?
    var alcohol_strength:Any?
    var oak_id:Any?
    var tannin_id:Any?
    var acidity_id:Any?
    var year:Any?
    var winesearcher_bottle_price:Any?
    var winesearcher_glass_price:Any?
    var retailer_bottle_price:Any?
    var retailer_glass_price:Any?
    var wine_searcher_price_last_updated:Any?
    var retailer_price_last_updated:Any?
    var bottle_size_ml:Any?
    var date_entered:Any?
    var date_updated:Any?
    var tasting_notes:Any?
    var retailer_additional_notes:Any?
    var wine_data_source_url:Any?
    var is_active:Any?
    
    //================================
    //Following variables not available in every query
    //accessing them all willy nilly will give you a nil exception
    var retailer_name:String?
    var rating:String? //needs to be manually converted to an Int because of PHPs JSON limitations
    var rating_text:String?
    var retailer_address:String?
    var is_stretch_wine = ""
    var select_date:String?
    
    required init?(map: Map){
    }
    func mapping(map: Map) {
        wine_ai_id <- map["wine_ai_id"]
        wine_id <- map["wine_id"]
        retailer_id <- map["retailer_id"]
        wine_name <- map["wine_name"]
        wine_description <- map["wine_description"]
        winery_name <- map["winery_name"]
        wine_profile_id <- map["wine_profile_id"]
        wine_stretch_id <- map["wine_stretch_id"]
        variety_name <- map["variety_name"]
        winery_url <- map["winery_url"]
        photo_url <- map["photo_url"]
        country <- map["country"]
        state <- map["state"]
        region <- map["region"]
        subregion <- map["subregion"]
        vineyard <- map["vineyard"]
        wine_color_id <- map["wine_color_id"]
        wine_type_id <- map["wine_type_id"]
        alcohol_strength <- map["alcohol_strength"]
        oak_id <- map["oak_id"]
        tannin_id <- map["tannin_id"]
        acidity_id <- map["acidity_id"]
        year <- map["year"]
        winesearcher_bottle_price <- map["winesearcher_bottle_price"]
        winesearcher_glass_price <- map["winesearcher_glass_price"]
        retailer_bottle_price <- map["retailer_bottle_price"]
        retailer_glass_price <- map["retailer_glass_price"]
        wine_searcher_price_last_updated <- map["wine_searcher_price_last_updated"]
        retailer_price_last_updated <- map["retailer_price_last_updated"]
        bottle_size_ml <- map["bottle_size_ml"]
        date_entered <- map["date_entered"]
        date_updated <- map["date_updated"]
        tasting_notes <- map["tasting_notes"]
        retailer_additional_notes <- map["retailer_additional_notes"]
        wine_data_source_url <- map["wine_data_source_url"]
        is_active <- map["is_active"]
        
        
        retailer_name <- map["retailer_name"]
        rating <- map["rating"]
        rating_text <- map["rating_text"]
        retailer_address <- map["retailer_address"]
        is_stretch_wine <- map["is_stretch_wine"]
        select_date <- map["select_date"]
    }
    
    
    func getWineaiid()->Int{
        if let val = wine_ai_id as? Int{
            return val
        }
        if let val = wine_ai_id as? String{
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
    
    func getRetailerid()->Int{
        if let val = retailer_id as? Int{
            return val
        }
        if let val = retailer_id as? String{
            return Int(val)!
        }
        else{
            return -1
        }//else
    }//func
    
    func getWinename()->String{
        if let val = wine_name as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getWinedescription()->String{
        if let val = wine_description as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getWineryname()->String{
        if let val = winery_name as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
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
    
    func getWinestretchid()->Int{
        if let val = wine_stretch_id as? Int{
            return val
        }
        if let val = wine_stretch_id as? String{
            return Int(val)!
        }
        else{
            return -1
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
    
    func getWineryurl()->String{
        if let val = winery_url as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getPhotourl()->String{
        if let val = photo_url as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getCountry()->String{
        if let val = country as? String{
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
    
    func getRegion()->String{
        if let val = region as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getSubregion()->String{
        if let val = subregion as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getVineyard()->String{
        if let val = vineyard as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
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
    
    func getWinetypeid()->Int{
        if let val = wine_type_id as? Int{
            return val
        }
        if let val = wine_type_id as? String{
            return Int(val)!
        }
        else{
            return -1
        }//else
    }//func
    
    func getAlcoholstrength()->String{
        if let val = alcohol_strength as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getOakid()->Int{
        if let val = oak_id as? Int{
            return val
        }
        if let val = oak_id as? String{
            return Int(val)!
        }
        else{
            return -1
        }//else
    }//func
    
    func getTanninid()->Int{
        if let val = tannin_id as? Int{
            return val
        }
        if let val = tannin_id as? String{
            return Int(val)!
        }
        else{
            return -1
        }//else
    }//func
    
    func getAcidityid()->Int{
        if let val = acidity_id as? Int{
            return val
        }
        if let val = acidity_id as? String{
            return Int(val)!
        }
        else{
            return -1
        }//else
    }//func
    
    func getYear()->Int{
        if let val = year as? Int{
            return val
        }
        if let val = year as? String{
            return Int(val)!
        }
        else{
            return -1
        }//else
    }//func
    
    func getWinesearcherbottleprice()->Double{
        if let val = winesearcher_bottle_price as? Double{
            return val
        }
        if let val = winesearcher_bottle_price as? String{
            return Double(val)!
        }
        else{
            return -1.0
        }//else
    }//func
    
    func getWinesearcherglassprice()->Double{
        if let val = winesearcher_glass_price as? Double{
            return val
        }
        if let val = winesearcher_glass_price as? String{
            return Double(val)!
        }
        else{
            return -1.0
        }//else
    }//func
    
    func getRetailerbottleprice()->Double{
        if let val = retailer_bottle_price as? Double{
            return val
        }
        if let val = retailer_bottle_price as? String{
            return Double(val)!
        }
        else{
            return -1.0
        }//else
    }//func
    
    func getRetailerglassprice()->Double{
        if let val = retailer_glass_price as? Double{
            return val
        }
        if let val = retailer_glass_price as? String{
            return Double(val)!
        }
        else{
            return -1.0
        }//else
    }//func
    
    func getWinesearcherpricelastupdated()->String{
        if let val = wine_searcher_price_last_updated as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getRetailerpricelastupdated()->String{
        if let val = retailer_price_last_updated as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getBottlesizeml()->Int{
        if let val = bottle_size_ml as? Int{
            return val
        }
        if let val = bottle_size_ml as? String{
            return Int(val)!
        }
        else{
            return -1
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
    
    func getDateupdated()->String{
        if let val = date_updated as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getTastingnotes()->String{
        if let val = tasting_notes as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getRetaileradditionalnotes()->String{
        if let val = retailer_additional_notes as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getWinedatasourceurl()->String{
        if let val = wine_data_source_url as? String{
            return val
        }
        else{
            return ""
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




class WineList : Mappable {
    
    
    var wineList = [Wine]()
    
    required init?(map: Map){
    }
    
    
    func mapping(map: Map) {
        wineList  <- map["wine_list"]
    }
    
    
}
