//
//  SSAnalytices.swift
//  SweetSpot
//
//  Created by Iziah Reid on 7/31/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import Foundation
import Alamofire

class SSAnalytics{
    
    enum AnalyticsActionType : String{
        case LOGIN
        case REGISTER
        case QUESTION_ONE
        case QUESTION_TWO
        case QUESTION_THREE
        case USER_SURVEY
        case HELP
        case PROFILE
        case DASHBOARD
        case FIND_MY_WINE_RETAIL_LIST
        case FIND_MY_WINE_LIST
        case FIND_MY_WINE_CAROUSEL
        case WINE_DETAIL
        case VIEW_MY_FAVORITE
        case DELETE_FAVORITE
        case REVIEW_WINE
        case WAS_WINE_AVAILABLE
        case VIEW_WINE_DETAILS
        case VIEW_RATE_WINE_ALL
        case VIEW_RATE_WINE_RATED
        case VIEW_RATE_WINE_UNRATED
        case SPLASH_SCREEN
        case FORGOT_PASSWORD
        
    }
    
    static func reportUserAction(action_type:AnalyticsActionType){
        
        let parameters: Parameters = ["action": "addCustomerAction",
                                      "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID"),
                                      "action_type":action_type
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
        }
        
    }
    
}
