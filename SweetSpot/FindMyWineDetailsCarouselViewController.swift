//
//  FindMyWineDetailsCarouselViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/5/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire
import DropDown

class FindMyWineCarouselCell: UICollectionViewCell {
    @IBOutlet var img_Wine: UIImageView!
    @IBOutlet var lbl_SweetSportWine: UILabel!
    @IBOutlet var lbl_WineName: UILabel!
    @IBOutlet var lbl_WineLocation: UILabel!
    @IBOutlet var lbl_WinePrice: UILabel!
    @IBOutlet var lbl_WineType: UILabel!
    @IBOutlet var lbl_WineCity: UILabel!
    @IBOutlet var lbl_WineDescription: UITextView!
    @IBOutlet var divider: UILabel!
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lbl_WineLocation.textColor = UIColor.AppColors.beige
        lbl_WinePrice.textColor = UIColor.AppColors.beige
        lbl_WineCity.textColor = UIColor.AppColors.grey
        lbl_WineDescription.textColor = UIColor.AppColors.grey
        divider.backgroundColor = UIColor.AppColors.grey
        
        lbl_SweetSportWine.layer.cornerRadius = 5
        lbl_SweetSportWine.clipsToBounds = true
        
        let contentViewRadius = CGFloat(75)
        if #available(iOS 11, *) {
            contentView.layer.cornerRadius = contentViewRadius
            contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            let rectShape = CAShapeLayer()
            rectShape.bounds = contentView.frame
            rectShape.position = contentView.center
            rectShape.path = UIBezierPath(roundedRect: contentView.bounds,
                                          byRoundingCorners: [.bottomLeft , .bottomRight , .topLeft],
                                          cornerRadii: CGSize(width: contentViewRadius, height: contentViewRadius)).cgPath
            contentView.layer.mask = rectShape
        }
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor.AppColors.purple
        //contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(10, 10, 10, 10))
        
//        btn_Details.layer.cornerRadius = btn_Details.frame.height / 2
//        btn_Details.layer.borderColor = UIColor.AppColors.beige.cgColor
//        btn_Details.layer.borderWidth = CGFloat(btn_border_width)
//        btn_Details.backgroundColor = UIColor.clear
//        btn_Details.setTitleColor(UIColor.AppColors.beige,
//                                  for: .normal)
//        btn_Details.setTitle("Details".uppercased(),
//                             for: .normal)
    }
}

class FindMyWineDetailsCarouselViewController:
    UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource
{
   
    @IBOutlet var mainTable: UICollectionView!
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
    var iListViewType = 1
    var iSellBy = 0
    var retailer:Retailer = Retailer(JSONString:"{}")!
    
    let ddSortByOptions = DropDown()
    let ddListViewTypes = DropDown()
    let ddSellByLists = DropDown()
    
    var wineList = WineList(JSONString: "{}")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.AppColors.purple
        
        
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
        text_ViewType.text = strListViewTypeList[1]
        self.ddListViewTypes.selectionAction = { [unowned self] (index: Int, item: String) in
            self.text_ViewType.text = item
            self.iListViewType = index
            if index == 0{
                print("show listview")
                 self.dismiss(animated: true, completion: nil)
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
        self.text_Address.rightView = addressRightInputImageView
        
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
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 24
        flowLayout.minimumLineSpacing = 24
        flowLayout.sectionInset = UIEdgeInsetsMake(32, 16, -32, 16)
        flowLayout.itemSize = CGSize(width: 275,
                                     height: self.mainTable.frame.height + 50
        )
  
        mainTable.setCollectionViewLayout(flowLayout, animated: true)
        
        let mainTableImage = UIImage(named: "group15")
        let mainTableImageView = UIImageView(frame: CGRect(x: 0,
                                                           y: 0,
                                                           width: 32,
                                                           height: self.mainTable.bounds.height))
        mainTableImageView.image = mainTableImage
        mainTableImageView.contentMode = .center
        mainTable.backgroundView = mainTableImageView
        loadMainTable()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.wineList.wineList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FindMyWineCarouselCell", for: indexPath) as! FindMyWineCarouselCell
        cell.backgroundColor = .clear
        
        let wine = self.wineList.wineList[indexPath.row ]
        cell.lbl_WineName.text = wine.getWinename()
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
        cell.lbl_WineCity.text = wine.getCountry() + ", " + wine.getRegion()
        cell.lbl_WinePrice.text = "$" + String(format:"%.2f", wine.getRetailerbottleprice())
        cell.lbl_WineType.text = "\(wine.getVarietyname())"
        cell.lbl_WineDescription.text = wine.getTastingnotes()
        if wine.is_stretch_wine == "1"{
            cell.lbl_SweetSportWine.text = "Try This Wine"
            cell.lbl_SweetSportWine.backgroundColor = UIColor.AppColors.grey
            cell.lbl_SweetSportWine.textColor = UIColor.AppColors.black
        }else{
           cell.lbl_SweetSportWine.text = "SweetSpot Wine"
        }
        
        if iSellBy == 1 {
            cell.lbl_WinePrice.text = "$" + String(format:"%.2f", wine.getRetailerglassprice())
            
        }else{
            cell.lbl_WinePrice.text = "$" + String(format:"%.2f", wine.getRetailerbottleprice())
        }
        
        
        if wine.getPhotourl() != ""{
            
            cell.img_Wine.imageFromUrl(theUrl: wine.getPhotourl())
        }
        return cell
    }
    
}
extension FindMyWineDetailsCarouselViewController: UITextFieldDelegate {
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

extension FindMyWineDetailsCarouselViewController: NavDelegate {
    func doDismiss() {
//        dismiss(animated: true,
//                completion: nil)
        self.presentingViewController?.view.isHidden = true
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
        
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

