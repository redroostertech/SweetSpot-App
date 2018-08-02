//
//  vwEmptyResults.swift
//  SweetSpot
//
//  Created by Iziah Reid on 8/1/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

class vwEmptyResults: UIView {

  
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblSecondaryDescription: UILabel!
    
    @IBOutlet weak var lblPrimaryDescription: UILabel!
    
    
    @IBOutlet weak var btnGoHome: UIButton!
    
    @IBOutlet weak var btnFindMyWines: UIButton!
    var delegate: vwEmptyResultsDelegate?
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.AppColors.purple
        
        lblTitle.textColor = .white
        lblPrimaryDescription.textColor = .white
        lblSecondaryDescription.textColor = .white

        btnGoHome.layer.cornerRadius = CGFloat(btn_radius)
        btnGoHome.backgroundColor = UIColor.AppColors.beige
        btnGoHome.setTitleColor(UIColor.AppColors.black,
                                     for: .normal)
        btnGoHome.setTitle("Find My Wines",
                                for: .normal) //had to switch this around real quick

        
        btnFindMyWines.layer.cornerRadius = CGFloat(btn_radius)
        btnFindMyWines.layer.borderColor = UIColor.AppColors.beige.cgColor
        btnFindMyWines.layer.borderWidth = CGFloat(btn_border_width)
        btnFindMyWines.backgroundColor = UIColor.clear
        btnFindMyWines.setTitleColor(UIColor.AppColors.beige,
                                for: .normal)
        
        btnFindMyWines.setTitle("Go Home",
                           for: .normal)//had to switch this around real quick
    }
    
    
    
    @IBAction func btnGoHome_Click(_ sender: Any) {
        self.removeFromSuperview()
         delegate?.btnFindMyWines_Click()
    }
    
    
    @IBAction func btnFindMyWines_Click(_ sender: Any) {
        self.removeFromSuperview()
       
        delegate?.btnGoHome_Click()
    }
    
}

protocol vwEmptyResultsDelegate {
    // Classes that adopt this protocol MUST define
    // this method -- and hopefully do something in
    // that definition.
    func btnGoHome_Click()
    func btnFindMyWines_Click()
}
