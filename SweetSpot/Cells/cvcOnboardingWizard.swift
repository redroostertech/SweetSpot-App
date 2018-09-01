//
//  cvcOnboardingWizard.swift
//  SweetSpot Beta
//
//  Created by Iziah Reid on 8/18/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

protocol cvcOnboardingWizardDelegate {
    func btnDone_Click()
}

class cvcOnboardingWizard: UICollectionViewCell {

    @IBOutlet weak var imgBackground: UIImageView!
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var lblDescription: UITextView!
    
    
    
    @IBOutlet weak var imgPosition1: UIImageView!
    
    @IBOutlet weak var imgPosition2: UIImageView!
    
    @IBOutlet weak var imgPosition3: UIImageView!
    
    @IBOutlet weak var imgPosition4: UIImageView!
    
    
    @IBOutlet weak var btnDone: UIButton!
    
    var delegate:cvcOnboardingWizardDelegate?
    @IBAction func btnDone_Click(_ sender: Any) {
        delegate?.btnDone_Click()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
