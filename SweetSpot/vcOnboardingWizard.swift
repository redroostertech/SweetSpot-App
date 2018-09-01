//
//  vcOnboardingWizard.swift
//  SweetSpot Beta
//
//  Created by Iziah Reid on 8/18/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import Foundation
import UIKit

class vcOnboardingWizard: UICollectionViewController, UICollectionViewDelegateFlowLayout, cvcOnboardingWizardDelegate {
    
    var arrOnboardingWizard = [OnboardingWizard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utils().savePermanentString(keyName: "DID_ONBOARD", keyValue: "1")
        
        var myItem = OnboardingWizard()
        myItem.title = "FIND"
        myItem.description = "Sweetspot helps you discover your perfect match at restaurants and stores. Only drink wines that fit your taste and budget"
        myItem.position = 1
        myItem.backgroundImageName = "wizard_screencap_1.png"
        myItem.iconImageName = "wizard_icon_1.png"
        arrOnboardingWizard.append(myItem)
        myItem = OnboardingWizard()
        myItem.title = "TASTE"
        myItem.description = "We'll recommend the best wines that fit your personal taste. Feeling adventurous? Click \"Try This\" to expand your palate."
        myItem.backgroundImageName = "wizard_screencap_2.png"
        myItem.iconImageName = "wizard_icon_2.png"
        myItem.position = 2
        arrOnboardingWizard.append(myItem)
        myItem = OnboardingWizard()
        myItem.title = "RATE"
        myItem.description = "The only rating that matters is yours. Rate and save wines in your personal cellar. Don't forget to share your favorites with friends."
        myItem.backgroundImageName = "wizard_screencap_3.png"
        myItem.iconImageName = "wizard_icon_3.png"
        myItem.position = 3
        arrOnboardingWizard.append(myItem)
        myItem = OnboardingWizard()
        myItem.title = "REFINE"
        myItem.description = "In the mood for something new? Change your profile anytime. The more wines you rate, the better SweetSpot matches your top picks"
        myItem.backgroundImageName = "wizard_screencap_4.png"
        myItem.iconImageName = "wizard_icon_4.png"
        myItem.position = 4
        arrOnboardingWizard.append(myItem)
        
        collectionView?.backgroundColor = UIColor.AppColors.dark_purple
        //collectionView?.register(cvcOnboardingWizard.self, forCellWithReuseIdentifier: "cvcOnboardingWizard")
        let nib = UINib(nibName: "cvcOnboardingWizard", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "cvcOnboardingWizard")
        
        collectionView?.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvcOnboardingWizard", for: indexPath) as! cvcOnboardingWizard
        
        let myItem = arrOnboardingWizard[indexPath.row]
        
        cell.imgBackground.image = UIImage(named: myItem.backgroundImageName)
        cell.imgIcon.image = UIImage(named: myItem.iconImageName)
        cell.lblTitle.text = myItem.title
        cell.lblDescription.text = myItem.description
        
        
        cell.imgPosition1.image = UIImage(named: getButtonImage(position: 1, row: indexPath.row))
        cell.imgPosition2.image = UIImage(named: getButtonImage(position: 2, row: indexPath.row))
        cell.imgPosition3.image = UIImage(named: getButtonImage(position: 3, row: indexPath.row))
        cell.imgPosition4.image = UIImage(named: getButtonImage(position: 4, row: indexPath.row))
        
        if indexPath.row < arrOnboardingWizard.count - 1{
            cell.btnDone.setTitle("SKIP", for: .normal)
        }else{
            cell.btnDone.setTitle("DONE", for: .normal)
        }
        cell.delegate = self
        return cell
    }
    
    func getButtonImage(position:Int, row:Int)->String{
        if position == (row + 1){
            return "group.png"
        }
        return "oval.png"
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func btnDone_Click() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ViewController")
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
}
