//
//  AddReviewViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/4/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire

class AddReviewViewController: UIViewController {

    @IBOutlet var view_PrimaryContainer: UIView!
    @IBOutlet var btn_Share: UIButton!
    @IBOutlet var btn_Submit: UIButton!
    @IBOutlet var btn_FinishLater: UIButton!
    @IBOutlet var lbl_WineName: UILabel!
    @IBOutlet var btn_Star: [UIButton]!
    @IBOutlet var btn_AddToSweetSpot: UIButton!
    @IBOutlet var text_AddReview: UITextView!
    
    var user: User!
    var wine:Wine = Wine(JSONString: "{}")!
    var rating = 0
    var primaryNavigationViewController: PrimaryNavigationViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.AppColors.purple.withAlphaComponent(0.8)
        
        lbl_WineName.text = wine.getWinename()
        
        view_PrimaryContainer.layer.cornerRadius = 100
        view_PrimaryContainer.clipsToBounds = true
        view_PrimaryContainer.layer.borderColor = UIColor.AppColors.black.cgColor
        view_PrimaryContainer.layer.borderWidth = 2
        view_PrimaryContainer.backgroundColor = UIColor.AppColors.plum
        
        btn_FinishLater.layer.cornerRadius = btn_FinishLater.frame.height / 2
        btn_FinishLater.layer.borderColor = UIColor.AppColors.beige.cgColor
        btn_FinishLater.layer.borderWidth = CGFloat(btn_border_width)
        btn_FinishLater.backgroundColor = UIColor.clear
        btn_FinishLater.setTitleColor(UIColor.AppColors.beige,
                                 for: .normal)
        btn_FinishLater.setTitle("Finish Later".uppercased(),
                            for: .normal)
        
        btn_Submit.layer.cornerRadius = btn_Submit.frame.height / 2
        btn_Submit.layer.borderColor = UIColor.AppColors.black.cgColor
        btn_Submit.layer.borderWidth = CGFloat(btn_border_width)
        btn_Submit.backgroundColor = UIColor.AppColors.beige
        btn_Submit.setTitleColor(UIColor.AppColors.black,
                              for: .normal)
        btn_Submit.setTitle("Submit".uppercased(),
                         for: .normal)
        
        var count = 1
        for star in btn_Star {
            star.tag = count
            count += 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func yes(_ sender: UIButton) {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    @IBAction func addStar(_ sender: UIButton) {
        print("Button Tag: ", sender.tag)
    }
    


}
