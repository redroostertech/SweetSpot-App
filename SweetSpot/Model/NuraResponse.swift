

import Foundation
import ObjectMapper



class NuraResponse : Mappable {
    var data:String?
    var data_model:String?
    var message:String?
    var status:Int?
    
    
    required init?(map: Map){
    }
    func mapping(map: Map) {
        data <- map["data"]
        data_model <- map["data_model"]
        message <- map["message"]
        status <- map["status"]
    }
    
    
   
    
}





