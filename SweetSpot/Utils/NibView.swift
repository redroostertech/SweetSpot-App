//
//  NibView.swift
//  SweetSpot
//
//  Created by Iziah Reid on 7/19/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import Foundation
import UIKit
class NibView: UIView {
    var view: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Setup view from .xib file
        xibSetup()
    }
}
private extension NibView {
    
    func xibSetup() {
        backgroundColor = UIColor.clear
        
    }
}

