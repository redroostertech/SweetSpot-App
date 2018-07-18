//
//  FindMyWineDetailsViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/5/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

class FindMyWineDetailsViewController: UIViewController {

    @IBOutlet var mainContainer: UIView!
    @IBOutlet var img_Wine: UIImageView!
    @IBOutlet var img_BG: UIImageView!
    @IBOutlet var lbl_SweetSportWine: UILabel!
    @IBOutlet var lbl_WineName: UILabel!
    @IBOutlet var lbl_WineLocation: UILabel!
    @IBOutlet var lbl_WinePrice: UILabel!
    @IBOutlet var lbl_WineType: UILabel!
    @IBOutlet var lbl_WineCity: UILabel!
    @IBOutlet var lbl_WineDescription: UITextView!
    @IBOutlet var divider: UILabel!
    @IBOutlet var lbl_AdditionalDetails: [UILabel]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setVCBackgroundImageToView(image: dashboard_background_image)
        
        mainContainer.clipsToBounds = true
        
        lbl_WineLocation.textColor = UIColor.AppColors.beige
        lbl_WinePrice.textColor = UIColor.AppColors.beige
        lbl_WineCity.textColor = UIColor.AppColors.grey
        lbl_WineDescription.textColor = UIColor.AppColors.grey
        divider.backgroundColor = UIColor.AppColors.grey
        
        lbl_SweetSportWine.layer.cornerRadius = 5
        lbl_SweetSportWine.clipsToBounds = true
        
        img_BG.clipsToBounds = true
        img_Wine.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.AppColors.purple
        
        var count = 1
        for label in lbl_AdditionalDetails {
            label.tag = count
            count += 1
            label.textColor = UIColor.AppColors.beige
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectWine(_ sender: UIButton) {
        dismiss(animated: true,
                completion: nil)
    }
    
}
