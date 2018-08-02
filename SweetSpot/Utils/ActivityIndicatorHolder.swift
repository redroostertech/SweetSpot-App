//
//  ViewControllerUtils.swift
//  SweetSpot
//
//  Created by Iziah Reid on 7/23/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicatorHolder{
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func showActivityIndicator(uiView: UIView) {
        var container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        
        
        container.backgroundColor = UIColor().fromHex(rgbValue: 0xffffff, alpha: 0.3)
        
        var loadingView: UIView = UIView()
        loadingView.frame = CGRect(x:0, y:0, width:80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor().fromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x:0.0, y:0.0, width:40.0, height:40.0);
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2,
                                y: loadingView.frame.size.height / 2);
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
    }
    
    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        //container.removeFromSuperview()
        for v:UIView in uiView.subviews{
            if v == container{
                v.removeFromSuperview()
            }
        }
    }
    
}
