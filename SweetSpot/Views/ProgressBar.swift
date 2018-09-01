//
//  ProgressBar.swift
//  SweetSpot Beta
//
//  Created by Iziah Reid on 8/17/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import Foundation
import UIKit

class ProgressBar: UIView {
    
    private var innerProgress: CGFloat = 0.0
    var progress : CGFloat {
        set (newProgress) {
            if newProgress > 1.0 {
                innerProgress = 1.0
            } else if newProgress < 0.0 {
                innerProgress = 0
            } else {
                innerProgress = newProgress
            }
            setNeedsDisplay()
        }
        get {
            return innerProgress * bounds.width
        }
    }
    
    override func draw(_ rect: CGRect) {
        Utils.drawProgressBar(frame: bounds,
                                          progress: progress)
    }
    
   
    
}
