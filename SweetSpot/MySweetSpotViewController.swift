//
//  MySweetSpotViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/5/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire

class MySweetSpotCell: UITableViewCell {
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var lbl_Distance: UILabel!
    @IBOutlet var lbl_BusinessName: UILabel!
    @IBOutlet var lbl_Address: UILabel!
    @IBOutlet var btn_GoTo: UIButton!
    @IBOutlet var lbl_Date: UILabel!
    
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

class MySweetSpotViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource
{
    
    @IBOutlet var mainTable: UITableView!
    @IBOutlet var navigationViewContainer: UIView!

    var navigation: SecondaryNavigationViewController!
    var wineList:WineList = WineList(JSONString: "{}")!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.AppColors.purple
        
        navigation = SecondaryNavigationViewController()
        addChildViewController(navigation)
        navigationViewContainer.addSubview(navigation.view)
        didMove(toParentViewController: navigation)
        navigation.delegate = self
        navigation.titleForView = "MY SWEETSPOT"
        
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.backgroundColor = UIColor.AppColors.dark_purple
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        loadMainTable()
    }
    
    func loadMainTable(){
        let parameters: Parameters = ["action": "getCustomerFavoriteWine",
                                      
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
                return
            }
            let data = jsonValues["data"] as! [String:Any]
            if let theJSONData = try? JSONSerialization.data( withJSONObject: data, options: []) {
                let theJSONText = String(data: theJSONData,
                                         encoding: .ascii)
                print("JSON string = \(theJSONText!)")
                
                self.wineList = WineList(JSONString: theJSONText!)!
                self.mainTable.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wineList.wineList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MySweetSpotCell", for: indexPath) as! MySweetSpotCell
        cell.backgroundColor = .clear
        
        let wine = self.wineList.wineList[indexPath.row]
        
        cell.lbl_Distance.text = wine.getWinename()
        if let retailer_name = wine.retailer_name{
            cell.lbl_BusinessName.text = retailer_name
        }
        
        if let retailer_address = wine.retailer_address{
            cell.lbl_Address.text = retailer_address
        }
        cell.mainImg.imageFromUrl(theUrl: wine.getPhotourl())
        //MySweetSpotRemoveWineViewController
        let removeWineGesture =  UITapGestureRecognizer(target: self, action: #selector(removeWine(_:)))
        removeWineGesture.numberOfTapsRequired = 1
        cell.btn_GoTo.addGestureRecognizer(removeWineGesture)
        return cell
    }
    
    @objc func removeWine(_ sender: UIGestureRecognizer){
        let tapLocation = sender.location(in: self.mainTable)
        let indexPath = self.mainTable.indexPathForRow(at: tapLocation)
        let wine = self.wineList.wineList[(indexPath?.row)!]
        
        if let viewController = self.programmaticSegue(vcName: "MySweetSpotRemoveWineViewController", storyBoard: "Main") as? MySweetSpotRemoveWineViewController {
            
            viewController.wine = wine
            self.present(viewController, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension MySweetSpotViewController: NavDelegate {
    func doDismiss() {
        dismiss(animated: true,
                completion: nil)
    }
    
    func doGoToProfile() {
        
        if !(self is ProfileContainerViewController) {
            let sb = UIStoryboard(name: "Main",
                                  bundle: nil)
            guard
                let vc = sb.instantiateViewController(withIdentifier: "ProfileContainerViewController") as? ProfileContainerViewController
                else
            {
                return
            }
            //vc.user = self.user
            present(vc,
                    animated: true,
                    completion: nil)
        }
    }
    
    func doGoToHelp() {
        if !(self is ProfileContainerViewController) {
            let sb = UIStoryboard(name: "Main",
                                  bundle: nil)
            guard
                let vc = sb.instantiateViewController(withIdentifier: "HelpViewController") as? HelpViewController
                else
            {
                return
            }
            //vc.user = self.user
            present(vc,
                    animated: true,
                    completion: nil)
        }
    }
}