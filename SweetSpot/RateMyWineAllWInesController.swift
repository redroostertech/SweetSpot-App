//
//  RateMyWineAllWInesController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/5/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire

class RateMyWineCell: UITableViewCell {
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var lbl_Distance: UILabel!
    @IBOutlet var lbl_BusinessName: UILabel!
    @IBOutlet var lbl_Address: UILabel!
 
    @IBOutlet weak var btn_GoTo: UIButton!
    @IBOutlet var lbl_Date: UILabel!
    @IBOutlet var btn_Star: [UIButton]!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImg.layer.cornerRadius = 5
        mainImg.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor.AppColors.purple
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(10, 10, 10, 10))
        lbl_Distance.textColor = UIColor.AppColors.beige
        lbl_BusinessName.textColor = UIColor.AppColors.beige
        lbl_Address.textColor = UIColor.AppColors.beige
    }
}
class RateMyWineUnRatedCell: UITableViewCell {
    
    
    @IBOutlet weak var btn_RateThisWine: UIButton!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var lbl_BusinessName: UILabel!
    @IBOutlet weak var lbl_Distance: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImg.layer.cornerRadius = 5
        mainImg.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor.AppColors.purple
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(10, 10, 10, 10))
        lbl_Distance.textColor = UIColor.AppColors.beige
        lbl_BusinessName.textColor = UIColor.AppColors.beige
        lbl_Address.textColor = UIColor.AppColors.beige

        btn_RateThisWine.layer.cornerRadius = btn_RateThisWine.frame.height / 2
        btn_RateThisWine.layer.borderColor = UIColor.AppColors.beige.cgColor
        btn_RateThisWine.layer.borderWidth = CGFloat(btn_border_width)
        btn_RateThisWine.backgroundColor = UIColor.clear
        btn_RateThisWine.setTitleColor(UIColor.AppColors.beige,
                                       for: .normal)
        btn_RateThisWine.setTitle("  Rate This Wine".uppercased(),
                                  for: .normal)
    }
}


class RateMyWineAllWInesController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource, vwEmptyResultsDelegate
{
    
    @IBOutlet var mainTable: UITableView!
    var wineList:WineList = WineList(JSONString: "{}")!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.AppColors.purple
        
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.backgroundColor = UIColor.AppColors.dark_purple
        SSAnalytics.reportUserAction(action_type: SSAnalytics.AnalyticsActionType.VIEW_RATE_WINE_ALL)
    }
    override func viewWillAppear(_ animated: Bool) {
        print("view will load")
       
        loadMainTable()
    }
    
    func loadMainTable(){
        let parameters: Parameters = ["action": "getCustomerRatedWine",
                                      "rating_type":"1",
                                      "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID")
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            if response.result.value == nil{
                return
            }
            let jsonValues = response.result.value as! [String:Any]
            
            let status = jsonValues["status"] as? Int
            if status != 1{
                print("error from server: \(jsonValues["message"])")
                self.wineList = WineList(JSONString: "{}")!
                self.mainTable.reloadData()
                self.showEmptyResults()
                return
            }
            let data = jsonValues["data"] as! [String:Any]
            if let theJSONData = try? JSONSerialization.data( withJSONObject: data, options: []) {
                let theJSONText = String(data: theJSONData,
                                         encoding: .ascii)
                 //print("JSON string = \(theJSONText!)")
                 
                
                self.wineList = WineList(JSONString: theJSONText!)!
                print("\(self.wineList.wineList[0].rating!)")
                DispatchQueue.main.async {
                    for subview in self.mainTable.subviews{
                        subview.removeFromSuperview()
                    }
                    self.mainTable.reloadData()
                }
                
            }
            if self.wineList.wineList.count == 0 {
                 self.showEmptyResults()
            }
        }
    }
    
    func showEmptyResults(){
        let customView = vwEmptyResults().loadNib(myNibName: "vwEmptyResults") as! vwEmptyResults
        customView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 150)
        customView.alpha = 1
        
        customView.lblTitle.text = "You Have No Wines To Rate"
        customView.lblPrimaryDescription.text = "You have not selected any of our wine recommendations yet."
        customView.lblSecondaryDescription.text = "Click the + icon to add wines to this page."
        customView.delegate = self
        self.view.addSubview(customView)
    }
    
    func btnFindMyWines_Click() {
        let presentingViewController = self.presentingViewController
        self.dismiss(animated: true, completion: {
            if let viewController = self.programmaticSegue(vcName: "FindMyWineViewController", storyBoard: "Main") as? FindMyWineViewController {
                
                presentingViewController?.present(viewController, animated: true, completion: nil)
                
            }
        })
    }
    func btnGoHome_Click() {
         self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wineList.wineList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wine = self.wineList.wineList[indexPath.row]
       
        var rating = 0
        if let strRating = wine.rating{
            if Int(strRating) != nil{
                rating = Int(strRating)!
            }
        }
        if rating > 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RateMyWineCell", for: indexPath) as! RateMyWineCell
            cell.backgroundColor = .clear
            cell.lbl_Distance.text = wine.getWinename()
            cell.lbl_Distance.adjustsFontSizeToFitWidth = true
            cell.mainImg.imageFromUrl(theUrl: wine.getPhotourl())
            if let retailer_name = wine.retailer_name{
                cell.lbl_BusinessName.text = retailer_name
                
            }
            if let retailer_address = wine.retailer_address{
                cell.lbl_Address.text = retailer_address
            }
            for index in 0...(cell.btn_Star.count - 1){
                if index >= rating {
                    cell.btn_Star[index].isHidden = true
                }else{
                    cell.btn_Star[index].isHidden = false
                }
            }
            
            if let select_date = wine.select_date{
                let date = String.getDateFromString(strDate: select_date, dateFormat: AppConstants.MYSQL_DATE_FORMAT)
                let strFormattedDate = String.getFormattedDate(date: date, dateFormat: "MM - dd - YY")
                cell.lbl_Date.text = strFormattedDate
            }
            let rateWineGesture =  UITapGestureRecognizer(target: self, action: #selector(rateThisWine(_:)))
            rateWineGesture.numberOfTapsRequired = 1
            cell.btn_GoTo.addGestureRecognizer(rateWineGesture)
            
            return cell
        }else{
           
            //tableView.register(RateMyWineUnRatedCell.self, forCellReuseIdentifier: "RateMyWineUnRatedCell")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RateMyWineUnRatedCell", for: indexPath) as! RateMyWineUnRatedCell
            cell.backgroundColor = .clear

            cell.lbl_Distance.text = wine.getWinename()
             cell.lbl_Distance.adjustsFontSizeToFitWidth = true
            cell.mainImg.imageFromUrl(theUrl: wine.getPhotourl())
            if let retailer_name = wine.retailer_name{
                cell.lbl_BusinessName.text = retailer_name
                cell.lbl_BusinessName.adjustsFontSizeToFitWidth = true
            }
            if let retailer_address = wine.retailer_address{
                cell.lbl_Address.text = retailer_address
            }
            if let select_date = wine.select_date{
                let date = String.getDateFromString(strDate: select_date, dateFormat: AppConstants.MYSQL_DATE_FORMAT)
                let strFormattedDate = String.getFormattedDate(date: date, dateFormat: "MM - dd - YY")
                cell.lbl_Date.text = strFormattedDate
            }
            let rateWineGesture =  UITapGestureRecognizer(target: self, action: #selector(rateThisWine(_:)))
            rateWineGesture.numberOfTapsRequired = 1
            cell.btn_RateThisWine.addGestureRecognizer(rateWineGesture)
            return cell
        }
    }
    
    @objc func rateThisWine(_ sender: UIGestureRecognizer){
        
        let tapLocation = sender.location(in: self.mainTable)
        let indexPath = self.mainTable.indexPathForRow(at: tapLocation)
        let wine = self.wineList.wineList[(indexPath?.row)!]
        print("rateThisWine")
        if let viewController = self.programmaticSegue(vcName: "AddReviewViewController", storyBoard: "Main") as? AddReviewViewController {
            
            viewController.wine = wine
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let wine = self.wineList.wineList[indexPath.row]
        var rating = 0
        if let strRating = wine.rating{
            if Int(strRating) != nil{
                rating = Int(strRating)!
            }
        }
        if rating > 0{
            return 175
        }else{
            return 160
        }
    }
}
