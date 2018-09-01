

import Foundation
import ObjectMapper



class Customer : Mappable {
    var customer_id:Any?
    var first_name:Any?
    var last_name:Any?
    var email_address:Any?
    var password:Any?
    var phone_number:Any?
    var zip_code:Any?
    var gender_id:Any?
    var salary_range_id:Any?
    var marital_status_id:Any?
    var age_range_id:Any?
    var color_id:Any?
    var price_id:Any?
    var wine_profile_id:Any?
    var app_last_used:Any?
    var profile_last_updated:Any?
    
    
    var gender_name:String?
    var salary_name:String?
    var marital_name:String?
    var age_name:String?
    var wine_color_name:String?
    var wine_pricing_name:String?
    var wine_selected_name:String?
    var wine_profile_name:String?
    
    required init?(map: Map){
    }
    func mapping(map: Map) {
        customer_id <- map["customer_id"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        email_address <- map["email_address"]
        password <- map["password"]
        phone_number <- map["phone_number"]
        zip_code <- map["zip_code"]
        gender_id <- map["gender_id"]
        salary_range_id <- map["salary_range_id"]
        marital_status_id <- map["marital_status_id"]
        age_range_id <- map["age_range_id"]
        color_id <- map["color_id"]
        price_id <- map["price_id"]
        wine_profile_id <- map["wine_profile_id"]
        app_last_used <- map["app_last_used"]
        profile_last_updated <- map["profile_last_updated"]
        
        gender_name <- map["gender_name"]
        salary_name <- map["salary_name"]
        marital_name <- map["marital_name"]
        age_name <- map["age_name"]
        wine_color_name <- map["wine_color_name"]
        wine_pricing_name <- map["wine_pricing_name"]
        wine_selected_name <- map["wine_selected_name"]
         wine_profile_name <- map["wine_profile_name"]
    }
    
    
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
    
    func getFirstname()->String{
        if let val = first_name as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getLastname()->String{
        if let val = last_name as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getEmailaddress()->String{
        if let val = email_address as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getPassword()->String{
        if let val = password as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getPhonenumber()->String{
        if let val = phone_number as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getZipcode()->String{
        if let val = zip_code as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getGenderid()->Int{
        if let val = gender_id as? Int{
            return val
        }
        if let val = gender_id as? String{
            return Int(val)!
        }
        else{
            return -1
        }//else
    }//func
    
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
    
    func getMaritalstatusid()->Int{
        if let val = marital_status_id as? Int{
            return val
        }
        if let val = marital_status_id as? String{
            return Int(val)!
        }
        else{
            return -1
        }//else
    }//func
    
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
    
    func getColorid()->Int{
        if let val = color_id as? Int{
            return val
        }
        if let val = color_id as? String{
            return Int(val)!
        }
        else{
            return -1
        }//else
    }//func
    
    func getPriceid()->Int{
        if let val = price_id as? Int{
            return val
        }
        if let val = price_id as? String{
            return Int(val)!
        }
        else{
            return -1
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
    
    func getApplastused()->String{
        if let val = app_last_used as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
    func getProfilelastupdated()->String{
        if let val = profile_last_updated as? String{
            return val
        }
        else{
            return ""
        }//else
    }//func
    
}




class CustomerList : Mappable {
    
    
    var customerList = [Customer]()
    
    required init?(map: Map){
    }
    
    
    func mapping(map: Map) {
        customerList  <- map[""]
    }
    
    
}
