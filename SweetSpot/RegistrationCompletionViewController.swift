//
//  RegistrationCompletionViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/1/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire

class RegistrationCompletionViewController: UIViewController {
    
    @IBOutlet var lbl_TitleOfView: UILabel!
    @IBOutlet var lbl_Header: UILabel!
    @IBOutlet var lbl_Type: UILabel!
    @IBOutlet var img_Type: UIImageView!
    @IBOutlet var lbl_FYI: UILabel!
    @IBOutlet var btn_Finished: UIButton!
    
    //var questionaireFinalStepDataSource: QuestionaireFinalStepDataSource?
    var picker: UIPickerView?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.AppColors.purple
        
        lbl_TitleOfView.textColor = UIColor.AppColors.beige
        lbl_TitleOfView.text = String(format: "%@ %@",
                                      completion_title,
                                      user?.firstName ?? "Larry").uppercased()
        lbl_TitleOfView.text = questionaire_title.uppercased()
        lbl_Header.textColor = UIColor.AppColors.beige
        lbl_Type.textColor = UIColor.AppColors.beige
        lbl_FYI.textColor = UIColor.AppColors.beige
        lbl_TitleOfView.textColor = UIColor.AppColors.beige
        
        btn_Finished.layer.cornerRadius = CGFloat(btn_radius)
        btn_Finished.layer.borderColor = UIColor.AppColors.black.cgColor
        btn_Finished.layer.borderWidth = CGFloat(btn_border_width)
        btn_Finished.backgroundColor = UIColor.AppColors.beige
        btn_Finished.setTitleColor(UIColor.AppColors.black,
                                   for: .normal)
        btn_Finished.setTitle(registration_finished.uppercased(),
                              for: .normal)
        
        img_Type.clipsToBounds = true
        self.lbl_Type.text = ""
        loadWineType()
//        let backgroundRadius = background.frame.width * 0.4
//        if #available(iOS 11, *) {
//            background.layer.cornerRadius = backgroundRadius
//            background.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        } else {
//            let rectShape = CAShapeLayer()
//            rectShape.bounds = background.frame
//            rectShape.position = background.center
//            rectShape.path = UIBezierPath(roundedRect: background.bounds,
//                                          byRoundingCorners: [.bottomLeft , .bottomRight],
//                                          cornerRadii: CGSize(width: backgroundRadius, height: backgroundRadius)).cgPath
//            background.layer.mask = rectShape
//        }
//        background.clipsToBounds = true

    }
    
    func loadWineType(){
        let parameters: Parameters = ["action": "getUserWineProfile",
                                      "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID")
                                      
            
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
           
             let jsonValues = response.result.value as! [String:Any]
            let data = jsonValues["data"] as! [String:Any]
            if let theJSONData = try? JSONSerialization.data(
                withJSONObject: data,
                options: []) {
                let theJSONText = String(data: theJSONData,
                                         encoding: .ascii)
                let wineProfile = WineProfile(JSONString: theJSONText!)!
                self.lbl_Type.text = wineProfile.getWineprofilename()
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func goToDashboard(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main",
                              bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController else {
            return
        }
        vc.user = self.user
        self.present(vc,
                     animated: true,
                     completion: nil)
        
    }
}
