//
//  MySweetSpotEmptyView.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/30/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

class EmptyView: UIViewController {

    @IBOutlet var imageviewMain: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblPrimaryDescription: UILabel!
    @IBOutlet var lblSecondaryDescription: UILabel!
    @IBOutlet var btnFindMyWines: UIButton!
    @IBOutlet var btnGoHome: UIButton!
    
    var titleText: String? {
        didSet {
            guard let titleText = self.titleText else { return }
            self.lblTitle.text = titleText
        }
    }
    
    var primaryDescriptionText: String? {
        didSet {
            guard let primaryDescriptionText = self.primaryDescriptionText else { return }
            self.lblPrimaryDescription.text = primaryDescriptionText
        }
    }
    
    var secondaryDescriptionText: String? {
        didSet {
            guard let secondaryDescriptionText = self.secondaryDescriptionText else { return }
            self.lblSecondaryDescription.text = secondaryDescriptionText
        }
    }
    
    var textFMWbtn: String? {
        didSet {
            guard let textFMWbtn = self.textFMWbtn else { return }
            self.btnFindMyWines.setTitle(textFMWbtn.uppercased(),
                                         for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.AppColors.purple
        
        lblTitle.textColor = .white
        lblPrimaryDescription.textColor = .white
        lblSecondaryDescription.textColor = .white

        btnFindMyWines.layer.cornerRadius = CGFloat(btn_radius)
        btnFindMyWines.backgroundColor = UIColor.AppColors.beige
        btnFindMyWines.setTitleColor(UIColor.AppColors.black,
                                     for: .normal)
        btnFindMyWines.setTitle(login_get_started.uppercased(),
                                for: .normal)
    
        btnGoHome.layer.cornerRadius = CGFloat(btn_radius)
        btnGoHome.layer.borderColor = UIColor.AppColors.beige.cgColor
        btnGoHome.layer.borderWidth = CGFloat(btn_border_width)
        btnGoHome.backgroundColor = UIColor.clear
        btnGoHome.setTitleColor(UIColor.AppColors.beige,
                                 for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
