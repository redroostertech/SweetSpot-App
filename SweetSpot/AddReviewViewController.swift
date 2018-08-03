//
//  AddReviewViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/4/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire
import Social

class AddReviewViewController: UIViewController, UITextViewDelegate {
    
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
    var return_two_view_controller = false
    var selectedRating:Int = 0
    var primaryNavigationViewController: PrimaryNavigationViewController!
    let TV_REVIEW_DEFAULT_TEXT = "Type in your comment here..."
    
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
        text_AddReview.delegate = self
        text_AddReview.text = TV_REVIEW_DEFAULT_TEXT
        
        if let rating_text = wine.rating_text{
            text_AddReview.text = rating_text
        }
        if let strRating = wine.rating{
            if let rating = Int(strRating){
                //highlight this many stars
                for star in btn_Star {
                    star.setTitleColor(UIColor.AppColors.beige, for: .normal)
                }
            }
            
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == TV_REVIEW_DEFAULT_TEXT{
           textView.text = ""
        }
    }
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.text = TV_REVIEW_DEFAULT_TEXT
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func yes(_ sender: UIButton) {
        SSAnalytics.reportUserAction(action_type: SSAnalytics.AnalyticsActionType.REVIEW_WINE)
        let parameters: Parameters = [
            "action": "rateSelectedWine",
            "wine_id": "\(wine.getWineaiid())",
            "rating": "\(selectedRating)",
            "rating_text":text_AddReview.text!,
            "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID")
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            self.doDismiss()
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
         SSAnalytics.reportUserAction(action_type: SSAnalytics.AnalyticsActionType.REVIEW_WINE_CANCEL)
        self.doDismiss()
    }
    
    @IBAction func addStar(_ sender: UIButton) {
        print("Button Tag: ", sender.tag)
        
        selectedRating = sender.tag
       
        for star in btn_Star {
            if star.tag <= selectedRating{
                let filled_star = UIImage(named: "star4")
                star.setImage(filled_star, for: .normal)
                
            }else{
                let filled_star = UIImage(named: "star5")
                star.setImage(filled_star, for: .normal)
            }
        }
        
    }
    
    func doDismiss(){
        NotificationCenter.default.post(name: .addReviewDismissed, object: nil)
        if !self.return_two_view_controller {
            self.dismiss(animated: true,
                         completion: nil)
        }else{
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
}
