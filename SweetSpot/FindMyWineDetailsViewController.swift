//
//  FindMyWineDetailsViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/5/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire
import DropDown
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

    var wine:Wine = Wine(JSONString:"{}")!
    
    @IBOutlet weak var btnCloseDetails: UIButton!

    @IBAction func btnCloseDetails_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setVCBackgroundImageToView(image: dashboard_background_image)
        
        mainContainer.clipsToBounds = true
        
        lbl_WineLocation.textColor = UIColor.AppColors.beige
        lbl_WineLocation.text = wine.getWineryname()
        lbl_WinePrice.textColor = UIColor.AppColors.beige
        //String(format:"%.2f", doubleValue)
        lbl_WinePrice.text = "$"+String(format:"%.2f", wine.getRetailerbottleprice())
        lbl_WineCity.textColor = UIColor.AppColors.grey
        lbl_WineCity.text = wine.getCountry() + ", " + wine.getRegion()
        lbl_WineDescription.textColor = UIColor.AppColors.grey
        lbl_WineDescription.text = wine.getTastingnotes()
        divider.backgroundColor = UIColor.AppColors.grey
        
        lbl_WineType.text = wine.getVarietyname()
        
        lbl_SweetSportWine.layer.cornerRadius = 5
        lbl_SweetSportWine.clipsToBounds = true
        
        lbl_WineName.text = wine.getWinename()
        
        img_BG.clipsToBounds = true
        img_Wine.clipsToBounds = true
        img_Wine.imageFromUrl(theUrl: wine.getPhotourl())
        self.view.backgroundColor = UIColor.AppColors.purple
        
        var count = 1
        print("\(wine.toJSONString())")
        for label in lbl_AdditionalDetails {
            label.tag = count
            count += 1
            label.textColor = UIColor.AppColors.beige
            if label.text == "Tannin" && wine.getAlcoholstrength() != ""{
                print("wine alky: \(wine.getAlcoholstrength())")
                label.text = "Alcohol Strength: " + wine.getAlcoholstrength()
            }
            else if label.text == "Alcohol" && wine.getBottlesizeml() > 0 {
                label.text = "Bottle Size: \(wine.getBottlesizeml())"
            }
            else if label.text == "Tasting Notes" && wine.getWineryurl() != "" {
                print("wine url: \(wine.getWineryurl())")
                label.text = "\(wine.getWineryurl())"
                label.textColor = UIColor.AppColors.link_blue
                label.isUserInteractionEnabled = true
                let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openWineURL))
                
                label.addGestureRecognizer(tap)
            }
            else if label.text == "Color"{
                let color_id = wine.getWinecolorid()
                print("Color: \(color_id)")
                if color_id == 1{
                    label.text =  "Color: White"
                }else{
                    label.text =  "Color: Red"
                }
            }else{
                label.text = ""
            }
        }
        
        if wine.is_stretch_wine == "1" {
            lbl_SweetSportWine.text = "Try This Wine"
            lbl_SweetSportWine.backgroundColor = UIColor.AppColors.grey
            lbl_SweetSportWine.textColor = UIColor.AppColors.black
        }
    }
    @objc func openWineURL(sender:UITapGestureRecognizer) {
        guard let url = URL(string: wine.getWineryurl()) else {
            print("Can't convert to URL")
            return //be safe
        }
        UIApplication.shared.openURL(url)
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
