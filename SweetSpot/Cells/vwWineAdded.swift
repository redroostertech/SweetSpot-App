//
//  vwWineAdded.swift
//  SweetSpot
//
//  Created by Iziah Reid on 7/19/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//


import UIKit

class vwWineAdded: UIView {

    @IBOutlet weak var lbl_WineName: UILabel!
    
    
    @IBOutlet weak var btn_Close: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func btnClose_Click(_ sender: Any) {
        print("btnClose_Click")
        self.removeFromSuperview()
    }
    
}
