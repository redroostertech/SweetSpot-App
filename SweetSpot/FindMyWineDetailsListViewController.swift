//
//  FindMyWineDetailsListViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/4/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire
import DropDown

class FindMyWineSponsoredCell: UITableViewCell {
    @IBOutlet var lbl_Title: UILabel!
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var lbl_WineName: UILabel!
    @IBOutlet var lbl_Address: UILabel!
    @IBOutlet var lbl_Price: UILabel!
    @IBOutlet var btn_GoTo: UIButton!
    @IBOutlet var btn_Details: UIButton!
    
    @IBOutlet weak var btn_Favorite: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lbl_Title.textColor = UIColor.AppColors.beige
        
        mainImg.layer.cornerRadius = 5
        mainImg.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor.AppColors.purple
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(10, 10, 10, 10))
        lbl_WineName.textColor = UIColor.AppColors.beige
        lbl_Address.textColor = UIColor.AppColors.beige
        lbl_Price.textColor = UIColor.AppColors.beige
        
        btn_Details.layer.cornerRadius = btn_Details.frame.height / 2
        btn_Details.layer.borderColor = UIColor.AppColors.beige.cgColor
        btn_Details.layer.borderWidth = CGFloat(btn_border_width)
        btn_Details.backgroundColor = UIColor.clear
        btn_Details.setTitleColor(UIColor.AppColors.beige,
                                  for: .normal)
        btn_Details.setTitle("Details".uppercased(),
                             for: .normal)
        
        
    }
}

class FindMyWineRecommendedTitleCell: UITableViewCell {
    @IBOutlet var lbl_TitleOfView: UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()
        lbl_TitleOfView.textColor = UIColor.AppColors.beige
    }
}

class FindMyWineRecommendedCell: UITableViewCell {
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var lbl_WineName: UILabel!
    @IBOutlet var lbl_Address: UILabel!
    @IBOutlet var lbl_Price: UILabel!
    @IBOutlet var btn_GoTo: UIButton!
    @IBOutlet var btn_Details: UIButton!
    
    @IBOutlet weak var btn_Favorite: UIButton!
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImg.layer.cornerRadius = 5
        mainImg.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor.AppColors.purple
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(10, 10, 10, 10))
        lbl_WineName.textColor = UIColor.AppColors.beige
        lbl_Address.textColor = UIColor.AppColors.beige
        lbl_Price.textColor = UIColor.AppColors.beige
        
        btn_Details.layer.cornerRadius = btn_Details.frame.height / 2
        btn_Details.layer.borderColor = UIColor.AppColors.beige.cgColor
        btn_Details.layer.borderWidth = CGFloat(btn_border_width)
        btn_Details.backgroundColor = UIColor.clear
        btn_Details.setTitleColor(UIColor.AppColors.beige,
                                  for: .normal)
        btn_Details.setTitle("Details".uppercased(),
                             for: .normal)
    }
}

class FindMyWineDetailsListViewController: UIViewController,
    UITableViewDelegate,
    UITableViewDataSource
{
    
    @IBOutlet var mainTable: UITableView!
    @IBOutlet var navigationViewContainer: UIView!
    @IBOutlet var text_Address: UITextField!
    @IBOutlet var text_SortBy: UITextField!
    @IBOutlet var text_ViewType: UITextField!
    @IBOutlet var text_Bottle: UITextField!
    
    var navigation: SecondaryNavigationViewController!
    
    let strSortByOptionsList = ["Low To High", "High To Low", "A-Z", "Z-A"]
    let strListViewTypeList = ["List View","Carousel View"]
    let strSellByList = ["By Bottle", "By Glass"]
    
    var iSortByOption = 0
    var iListViewType = 0
    var iSellBy = 0
    var retailer:Retailer = Retailer(JSONString:"{}")!
    
    let ddSortByOptions = DropDown()
    let ddListViewTypes = DropDown()
    let ddSellByLists = DropDown()
    
    var wineList = WineList(JSONString: "{}")!
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        text_Address.isEnabled = false
        text_Address.text = self.retailer.getRetailername()
        ddSortByOptions.dataSource = strSortByOptionsList
        ddSortByOptions.anchorView = text_SortBy
        text_SortBy.delegate = self
        text_SortBy.text = strSortByOptionsList[0]
        self.ddSortByOptions.selectionAction = { [unowned self] (index: Int, item: String) in
            self.text_SortBy.text = item
            self.iSortByOption = index
            self.loadMainTable()
        }
        
        ddListViewTypes.dataSource = strListViewTypeList
        ddListViewTypes.anchorView = text_ViewType
        text_ViewType.delegate = self
        text_ViewType.text = strListViewTypeList[0]
        self.ddListViewTypes.selectionAction = { [unowned self] (index: Int, item: String) in
            self.text_ViewType.text = item
            self.iListViewType = index
            if index == 1{
                print("show carouselview")
                if let viewController = self.programmaticSegue(vcName: "FindMyWineDetailsCarouselViewController", storyBoard: "Main") as? FindMyWineDetailsCarouselViewController {
                    
                    viewController.retailer = self.retailer
                    self.present(viewController, animated: true, completion: nil)
                }
            }
        }
        
        ddSellByLists.dataSource = strSellByList
        ddSellByLists.anchorView = text_Bottle
        text_Bottle.delegate = self
        text_Bottle.text = strSellByList[0]
        self.ddSellByLists.selectionAction = { [unowned self] (index: Int, item: String) in
            self.text_Bottle.text = item
            self.iSellBy = index
            self.loadMainTable()
        }
        
        
        
        self.view.backgroundColor = UIColor.AppColors.purple
        
        navigation = SecondaryNavigationViewController()
        addChildViewController(navigation)
        navigationViewContainer.addSubview(navigation.view)
        didMove(toParentViewController: navigation)
        navigation.delegate = self
        navigation.titleForView = "FIND MY WINE"
        
        let rightInputImage = UIImage(named: "dropDownArrow")
        
        let addressRightInputImage = UIImage(named: "shape")
        let addressRightInputImageView = UIImageView(frame: CGRect(x: 0,
                                                                   y: 0,
                                                                   width: 32,
                                                                   height: self.text_Address.frame.height))
        addressRightInputImageView.image = addressRightInputImage
        addressRightInputImageView.contentMode = .center
        self.text_Address.rightViewMode = .always
        self.text_Address.textColor = UIColor.AppColors.beige
        //self.text_Address.rightView = addressRightInputImageView
        
        let sortByRightInputImageView = UIImageView(frame: CGRect(x: 0,
                                                                  y: 0,
                                                                  width: 32,
                                                                  height: self.text_ViewType.frame.height))
        sortByRightInputImageView.image = rightInputImage
        sortByRightInputImageView.contentMode = .center
        self.text_SortBy.rightViewMode = .always
        self.text_SortBy.textColor = UIColor.AppColors.beige
        self.text_SortBy.rightView = sortByRightInputImageView
        
        let retailersRightInputImageView = UIImageView(frame: CGRect(x: 0,
                                                                     y: 0,
                                                                     width: 32,
                                                                     height: self.text_ViewType.frame.height))
        retailersRightInputImageView.image = rightInputImage
        retailersRightInputImageView.contentMode = .center
        self.text_ViewType.rightViewMode = .always
        self.text_ViewType.textColor = UIColor.AppColors.beige
        self.text_ViewType.rightView = retailersRightInputImageView
        
        let distanceRightInputImageView = UIImageView(frame: CGRect(x: 0,
                                                                    y: 0,
                                                                    width: 32,
                                                                    height: self.text_Bottle.frame.height))
        distanceRightInputImageView.image = rightInputImage
        distanceRightInputImageView.contentMode = .center
        self.text_Bottle.rightViewMode = .always
        self.text_Bottle.textColor = UIColor.AppColors.beige
        self.text_Bottle.rightView = distanceRightInputImageView
        
        let sortTypeRightInputImageView = UIImageView(frame: CGRect(x: 0,
                                                                    y: 0,
                                                                    width: 32,
                                                                    height: self.text_ViewType.frame.height))
        sortTypeRightInputImageView.image = rightInputImage
        sortTypeRightInputImageView.contentMode = .center
        self.text_ViewType.rightViewMode = .always
        self.text_ViewType.textColor = UIColor.AppColors.beige
        self.text_ViewType.rightView = sortTypeRightInputImageView
        
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.backgroundColor = UIColor.AppColors.dark_purple
        loadMainTable()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    
    func loadMainTable(){
        let parameters: Parameters = ["action": "getWineByRetailerID",
                                      "retailer_id": "\(retailer.getRetaileraiid())",
            "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID"),
            "sort_by":"\(iSortByOption)",
            "sell_by":"\(iSellBy)"
            
            
        ]
        
        print("retailer_id \(retailer.getRetaileraiid())")
        print("iSortByOption \(iSortByOption)")
        print("iSellBy \(iSellBy)")
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
    
    
    
    func findStretchWine()->Wine{
        var wine:Wine = Wine(JSONString:"{}")!
        for tmpWine in wineList.wineList{
            if tmpWine.is_stretch_wine == "1"{
                wine = tmpWine
            }
        }
        return wine
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        var listCount = 0
        listCount = self.wineList.wineList.count
        let wine = findStretchWine()
        if wine.getWineaiid() != -1{
             listCount = self.wineList.wineList.count +  2
        }
        return listCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
         let wine = findStretchWine()
        if indexPath.row == 0 {
            
            if wine.getWineaiid() == -1{
                return 0
            }
            return 200
        }
        
        if indexPath.row == 1 {
           
            if wine.getWineaiid() == -1{
                return 0
            }
            return 44
        }
        
        if wine.getWineaiid() != -1 && (indexPath.row ) > (self.wineList.wineList.count ) {
            return 0
        }
        return 175
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let stretch_wine = findStretchWine()
        print("cellForRowAt \(indexPath.row)")
        let hasStretchWine = (stretch_wine.getWineaiid() != -1)
        if indexPath.row == 0 && hasStretchWine{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FindMyWineSponsoredCell", for: indexPath) as! FindMyWineSponsoredCell
            cell.backgroundColor = .clear
            
            if stretch_wine.getWineaiid() != -1{
             cell.lbl_WineName.text = stretch_wine.getWinename()
            
            var address = ""
            if stretch_wine.getWineryname() != ""{
                address = address + stretch_wine.getWineryname() + "\n"
            }
            if stretch_wine.getCountry() != ""{
                address = address + stretch_wine.getCountry() + ", " + stretch_wine.getRegion() + "\n"
            }
            
            if stretch_wine.getVarietyname() != ""{
                address = address + stretch_wine.getVarietyname()
            }
            
            cell.lbl_Address.text = address
            if stretch_wine.getPhotourl() != ""{
                cell.mainImg.imageFromUrl(theUrl: stretch_wine.getPhotourl())
            }
            if iSellBy == 1 {
                cell.lbl_Price.text = "$" + String(format:"%.2f", stretch_wine.getRetailerglassprice())
               
            }else{
                 cell.lbl_Price.text = "$" + String(format:"%.2f", stretch_wine.getRetailerbottleprice())
            }
            
            let showDetailsGesture = UITapGestureRecognizer(target: self, action: #selector(showStretchDetails(_:)))
            showDetailsGesture.numberOfTapsRequired = 1
            cell.btn_Details.addGestureRecognizer(showDetailsGesture)
            
            let showWasWineAvailableGesture =  UITapGestureRecognizer(target: self, action: #selector(showStretchWasWineAvailable(_:)))
            showDetailsGesture.numberOfTapsRequired = 1
            cell.btn_GoTo.addGestureRecognizer(showWasWineAvailableGesture)
            
            
            let selectFavoriteGesture =  UITapGestureRecognizer(target: self, action: #selector(selectStretchFavorite(_:)))
            selectFavoriteGesture.numberOfTapsRequired = 1
            cell.btn_Favorite.addGestureRecognizer(selectFavoriteGesture)
            }
            
            return cell
            
        }
        
        if indexPath.row == 1 && hasStretchWine{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FindMyWineRecommendedTitleCell", for: indexPath) as! FindMyWineRecommendedTitleCell
            cell.backgroundColor = .clear
            let showDetailsGesture = UITapGestureRecognizer(target: self, action: #selector(showDetails(_:)))
            showDetailsGesture.numberOfTapsRequired = 1
           //just shows the title "Recommended Wines"
           
            return cell
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindMyWineRecommendedCell", for: indexPath) as! FindMyWineRecommendedCell
        cell.backgroundColor = .clear
        
        if indexPath.row - 2 >= 0 && (indexPath.row - 2) < (self.wineList.wineList.count - 1 ) {
            print("getting wine at index \(indexPath.row - 2)")
            let wine = self.wineList.wineList[indexPath.row - 2]
            cell.lbl_WineName.text = wine.getWinename()
            cell.lbl_WineName.adjustsFontSizeToFitWidth = true
            
            var address = ""
            if wine.getWineryname() != ""{
                address = address + wine.getWineryname() + "\n"
            }
            if wine.getCountry() != ""{
                address = address + wine.getCountry() + ", " + wine.getRegion() + "\n"
            }
            
            if wine.getVarietyname() != ""{
                address = address + wine.getVarietyname()
            }
            
            cell.lbl_Address.text = address
            
            if wine.getPhotourl() != ""{
                cell.mainImg.imageFromUrl(theUrl: wine.getPhotourl())
            }
            
            if iSellBy == 1 {
                cell.lbl_Price.text = "$" + String(format:"%.2f", wine.getRetailerglassprice())
                
            }else{
                cell.lbl_Price.text = "$" + String(format:"%.2f", wine.getRetailerbottleprice())
            }
            let showDetailsGesture = UITapGestureRecognizer(target: self, action: #selector(showDetails(_:)))
            showDetailsGesture.numberOfTapsRequired = 1
            cell.btn_Details.addGestureRecognizer(showDetailsGesture)
            
            let showWasWineAvailableGesture =  UITapGestureRecognizer(target: self, action: #selector(showWasWineAvailable(_:)))
            showDetailsGesture.numberOfTapsRequired = 1
            cell.btn_GoTo.addGestureRecognizer(showWasWineAvailableGesture)
            
            
            let selectFavoriteGesture =  UITapGestureRecognizer(target: self, action: #selector(selectFavorite(_:)))
            selectFavoriteGesture.numberOfTapsRequired = 1
            cell.btn_Favorite.addGestureRecognizer(selectFavoriteGesture)
            
        }
        return cell
    }
    
    @objc func selectFavorite(_ sender: UIGestureRecognizer){
        
        let tapLocation = sender.location(in: self.mainTable)
        let indexPath = self.mainTable.indexPathForRow(at: tapLocation)
        let wine = self.wineList.wineList[(indexPath?.row)! - 2]
        print("favorite selected")
        let parameters: Parameters = ["action": "addCustomerWineFavorite",
                                      "wine_id": "\(wine.getWineaiid())",
            "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID")
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            let customView = vwWineAdded().loadNib(myNibName: "vwWineAdded") as! vwWineAdded
            customView.lbl_WineName.text = wine.getWinename()
            customView.lblMessage.text = "WAS ADDED TO FAVORITES"
            customView.frame = CGRect(x: 0, y: 200, width: self.view.frame.width, height: 100)
            
            customView.alpha = 1
            self.view.addSubview(customView)
        }
    }
    @objc func selectStretchFavorite(_ sender: UIGestureRecognizer){
        
        let tapLocation = sender.location(in: self.mainTable)
        let indexPath = self.mainTable.indexPathForRow(at: tapLocation)
        let wine = self.wineList.wineList[self.wineList.wineList.count - 1]
        print("favorite selected")
        let parameters: Parameters = ["action": "addCustomerWineFavorite",
                                      "wine_id": "\(wine.getWineaiid())",
            "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID")
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            let customView = vwWineAdded().loadNib(myNibName: "vwWineAdded") as! vwWineAdded
            customView.lbl_WineName.text = wine.getWinename()
            customView.lblMessage.text = "WAS ADDED TO FAVORITES"
            customView.frame = CGRect(x: 0, y: 200, width: self.view.frame.width, height: 100)
            
            customView.alpha = 1
            self.view.addSubview(customView)
        }
    }
    
   
    
    @objc func showDetails(_ sender: UIGestureRecognizer){
        
        let tapLocation = sender.location(in: self.mainTable)
        
        let indexPath = self.mainTable.indexPathForRow(at: tapLocation)
        print("\(indexPath?.row)")
        let wine = self.wineList.wineList[(indexPath?.row)! - 2]
        if let viewController = self.programmaticSegue(vcName: "FindMyWineDetailsViewController", storyBoard: "Main") as? FindMyWineDetailsViewController {
            
            viewController.wine = wine
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    
    @objc func showStretchDetails(_ sender: UIGestureRecognizer){
        
        
        let wine = self.wineList.wineList[self.wineList.wineList.count - 1]
        if let viewController = self.programmaticSegue(vcName: "FindMyWineDetailsViewController", storyBoard: "Main") as? FindMyWineDetailsViewController {
            
            viewController.wine = wine
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @objc func showWasWineAvailable(_ sender: UIGestureRecognizer){
        let tapLocation = sender.location(in: self.mainTable)
        
        let indexPath = self.mainTable.indexPathForRow(at: tapLocation)
        print("\(indexPath?.row)")
        let wine = self.wineList.wineList[(indexPath?.row)! - 2]
        if let viewController = self.programmaticSegue(vcName: "WasWineAvailableViewController", storyBoard: "Main") as? WasWineAvailableViewController {
            
            viewController.wine = wine
            viewController.retailer = retailer
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @objc func showStretchWasWineAvailable(_ sender: UIGestureRecognizer){
       
        let wine = self.wineList.wineList[self.wineList.wineList.count - 1]
        if let viewController = self.programmaticSegue(vcName: "WasWineAvailableViewController", storyBoard: "Main") as? WasWineAvailableViewController {
            
            viewController.wine = wine
            viewController.retailer = retailer
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    
    
    
}


extension FindMyWineDetailsListViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case text_Bottle:
            self.ddSellByLists.show()
            self.view.endEditing(true)
            break
        case text_SortBy:
            self.ddSortByOptions.show()
            self.view.endEditing(true)
            break
        case text_ViewType:
            self.ddListViewTypes.show()
            self.view.endEditing(true)
            break
        default:
            break
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension FindMyWineDetailsListViewController: NavDelegate {
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
