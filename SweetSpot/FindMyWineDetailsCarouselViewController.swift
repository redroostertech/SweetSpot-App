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
    
    @IBOutlet weak var imgFavoriteWine: UIImageView!
    @IBOutlet weak var img_SelectWine: UIImageView!
    
    
    @IBOutlet weak var btnWineDetails: UIButton!
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
        
        btnWineDetails.layer.cornerRadius = btnWineDetails.frame.height / 2
        btnWineDetails.layer.borderColor = UIColor.AppColors.beige.cgColor
        btnWineDetails.layer.borderWidth = CGFloat(btn_border_width)
        btnWineDetails.backgroundColor = UIColor.clear
        btnWineDetails.setTitleColor(UIColor.AppColors.beige,
                                  for: .normal)
        btnWineDetails.setTitle("Details".uppercased(),
                             for: .normal)
    }
}

class FindMyWineDetailsCarouselViewController:
    UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource, vwEmptyWineDelegate, vwStretchSwipeDelegate
{
    
    @IBOutlet var mainTable: UICollectionView!
    @IBOutlet var navigationViewContainer: UIView!
    @IBOutlet var text_Address: UITextField!
    @IBOutlet var text_SortBy: UITextField!
    @IBOutlet var text_ViewType: UITextField!
    @IBOutlet var text_Bottle: UITextField!
    
  
    @IBOutlet weak var cstTableTop: NSLayoutConstraint!
    
    var navigation: SecondaryNavigationViewController!
    
    let strSortByOptionsList = ["Low To High", "High To Low", "A-Z", "Z-A"]
    let strListViewTypeList = ["Carousel View","List View"]
    let strSellByList = ["By Bottle", "By Glass"]
    
    var iSortByOption = 0
    var iListViewType = 1
    var iSellBy = 0
    var retailer:Retailer = Retailer(JSONString:"{}")!
    
    let ddSortByOptions = DropDown()
    let ddListViewTypes = DropDown()
    let ddSellByLists = DropDown()
    
    var wineList = WineList(JSONString: "{}")!
    
    
    
    var SHOW_STRETCH_WINE:Bool = false
    @IBOutlet weak var stretchSwipe: UIView!
    var stretchWineView:vwStretchSwipe?
    
    
    
    func addStretchWineView(){
        stretchWineView = vwStretchSwipe().loadNib(myNibName: "vwStretchSwipe") as! vwStretchSwipe
    
        stretchWineView?.frame = self.stretchSwipe.frame
        stretchWineView?.center = self.stretchSwipe.center
        stretchWineView?.delegate = self
        self.view.addSubview(stretchWineView!)
        
    }
    
    
   
    
    func displayStretchSwipe( display:Bool){
        if display{
             cstTableTop.constant = 90
             addStretchWineView()
           
            stretchWineView?.isHidden = false
        }else{
             cstTableTop.constant = 10
            UIView.animate(withDuration: 1.5) {
                self.view.layoutIfNeeded()
            }

//            UIView.transition(with: view, duration: 0.75, options: .transitionCrossDissolve, animations: {
//                self.stretchWineView?.removeFromSuperview()
//                self.stretchWineView?.isHidden = true
//            })
            
            
        }
    }
    
    func vwStretchSwipe_SwipeRight(){
        SHOW_STRETCH_WINE = true
       
        
        wineList.wineList = wineList.wineList.reversed()
        mainTable.reloadData()
        mainTable.scrollToItem(at: IndexPath(row: 0, section: 0),
                                          at: .left,
                                          animated: true)
        
        
        
        UIView.animate(withDuration: 0.75, animations: {
             self.stretchWineView?.progressBar.progress = 1
        }, completion: {(finished:Bool) in
            self.stretchWineView?.removeFromSuperview()
            self.stretchWineView?.isHidden = true
            self.displayStretchSwipe(display: false)
            
        })
      
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayStretchSwipe(display: false)
        SSAnalytics.reportUserAction(action_type: SSAnalytics.AnalyticsActionType.FIND_MY_WINE_CAROUSEL)
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
        text_ViewType.text = strListViewTypeList[0]
        self.ddListViewTypes.selectionAction = { [unowned self] (index: Int, item: String) in
            self.text_ViewType.text = item
            self.iListViewType = index
            if index == 1{
                print("show listview")
                
                if let viewController = self.programmaticSegue(vcName: "FindMyWineDetailsListViewController", storyBoard: "Main") as? FindMyWineDetailsListViewController {
                    viewController.retailer = self.retailer
                    self.present(viewController, animated: true, completion: nil)
                }
            }
        }
        
      
        ddSellByLists.dataSource = strSellByList
        if self.retailer.getRetailertypeid() > 1{
            ddSellByLists.dataSource = ["By Bottle"]
        }
        ddSellByLists.anchorView = text_Bottle
        text_Bottle.delegate = self
        text_Bottle.text = strSellByList[0]
        if self.retailer.getRetailertypeid() == 1{
            text_Bottle.text = strSellByList[1]
            iSellBy = 1 //default set to sell by glass if retailer is a restaurant
        }
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
                self.displayStretchSwipe(display: false)
                self.showEmptyResults()
                return
            }
            let jsonValues = response.result.value as! [String:Any]
            
            let status = jsonValues["status"] as? Int
            if status != 1{
                print("error from server: \(jsonValues["message"])")
                self.wineList = WineList(JSONString: "{}")!
                self.mainTable.reloadData()
                self.showEmptyResults()
                self.displayStretchSwipe(display: false)
                return
            }
            let data = jsonValues["data"] as! [String:Any]
            if let theJSONData = try? JSONSerialization.data( withJSONObject: data, options: []) {
                let theJSONText = String(data: theJSONData,
                                         encoding: .ascii)
                print("JSON string = \(theJSONText!)")
                
                self.wineList = WineList(JSONString: theJSONText!)!
                if let wine = self.findStretchWine(){
                     self.displayStretchSwipe(display: true)
                }
                
                self.mainTable.reloadData()
            }
            if self.wineList.wineList.count == 0{
                 self.displayStretchSwipe(display: false)
                self.showEmptyResults()
            }
        }
    }
    
    func showEmptyResults(){
        let customView = vwEmptyWine().loadNib(myNibName: "vwEmptyWine") as! vwEmptyWine
        customView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        customView.alpha = 1
        customView.delegate = self
        self.view.addSubview(customView)
    }
    
    func btnGetStarted_Click() {
        let presentingViewController = self.presentingViewController
        self.dismiss(animated: true, completion: {
            if let viewController = self.programmaticSegue(vcName: "ProfileContainerViewController", storyBoard: "Main") as? ProfileContainerViewController {
                viewController.navigatedFromEmptyScreen = true
                presentingViewController?.present(viewController, animated: true, completion: nil)
                
            }
        })
    }
    
    func btnCancel_Click() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if findStretchWine() != nil && SHOW_STRETCH_WINE == false{
            return self.wineList.wineList.count - 1
        }
        if findStretchWine() == nil && SHOW_STRETCH_WINE == false{
            print("logical error, this should never happen")
            return self.wineList.wineList.count
        }
        if findStretchWine() == nil && SHOW_STRETCH_WINE == true{
            return self.wineList.wineList.count
        }
        return self.wineList.wineList.count
    }
    
    func findStretchWine()->Wine?{
        var wine:Wine? = nil
        for tmpWine in wineList.wineList{
            if tmpWine.is_stretch_wine == "1"{
                wine = tmpWine
            }
        }
        return wine
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FindMyWineCarouselCell", for: indexPath) as! FindMyWineCarouselCell
        cell.backgroundColor = .clear
        
        let wine = self.wineList.wineList[indexPath.row ]
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
        cell.lbl_WineLocation.text = wine.getWineryname()
        cell.lbl_WineCity.text = wine.getCountry() + ", " + wine.getRegion()
        cell.lbl_WineCity.adjustsFontSizeToFitWidth = true
        cell.lbl_WinePrice.text = "$" + String(format:"%.2f", wine.getRetailerbottleprice())
        cell.lbl_WineType.text = "\(wine.getVarietyname())"
        cell.lbl_WineDescription.text = wine.getTastingnotes()
        if wine.is_stretch_wine == "1"{
            cell.lbl_SweetSportWine.text = "Try This Wine"
            cell.lbl_SweetSportWine.backgroundColor = UIColor.AppColors.grey
            cell.lbl_SweetSportWine.textColor = UIColor.AppColors.black
        }else{
            cell.lbl_SweetSportWine.text = "SweetSpot Wine"
             cell.lbl_SweetSportWine.backgroundColor = UIColor.AppColors.light_purple
             cell.lbl_SweetSportWine.textColor = UIColor.white
        }
        
        if iSellBy == 1 {
            cell.lbl_WinePrice.text = "$" + String(format:"%.2f", wine.getRetailerglassprice())
            
        }else{
            cell.lbl_WinePrice.text = "$" + String(format:"%.2f", wine.getRetailerbottleprice())
        }
        
        
        if wine.getPhotourl() != ""{
            
            cell.img_Wine.imageFromUrl(theUrl: wine.getPhotourl())
            //cell.img_Wine
            cell.img_Wine.clipsToBounds = true
            cell.img_Wine.contentMode = .scaleAspectFill
        }
        
        let showDetailsGesture = UITapGestureRecognizer(target: self, action: #selector(showDetails(_:)))
        showDetailsGesture.numberOfTapsRequired = 1
        cell.btnWineDetails.addGestureRecognizer(showDetailsGesture)
        
        let showWasWineAvailableGesture =  UITapGestureRecognizer(target: self, action: #selector(showWasWineAvailable(_:)))
        showWasWineAvailableGesture.numberOfTapsRequired = 1
        cell.img_SelectWine.addGestureRecognizer(showWasWineAvailableGesture)
        cell.img_SelectWine.isUserInteractionEnabled = true
        
        
        let selectFavoriteGesture =  UITapGestureRecognizer(target: self, action: #selector(selectFavorite(_:)))
        selectFavoriteGesture.numberOfTapsRequired = 1
        cell.imgFavoriteWine.addGestureRecognizer(selectFavoriteGesture)
        cell.imgFavoriteWine.isUserInteractionEnabled = true
        
        return cell
    }
    
    @objc func selectFavorite(_ sender: UIGestureRecognizer){
        
        let tapLocation = sender.location(in: self.mainTable)
        let indexPath = self.mainTable.indexPathForItem(at: tapLocation)
        let wine = self.wineList.wineList[(indexPath?.row)! ]
        print("favorite selected")
        let parameters: Parameters = ["action": "addCustomerWineFavorite",
                                      "wine_id": "\(wine.getWineaiid())",
            "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID")
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            let customView = vwWineAdded().loadNib(myNibName: "vwWineAdded") as! vwWineAdded
            customView.lbl_WineName.text = wine.getWinename()
            customView.lbl_WineName.adjustsFontSizeToFitWidth = true
            customView.lblMessage.text = "WAS ADDED TO FAVORITES"
            customView.frame = CGRect(x: 0, y: 200, width: self.view.frame.width, height: 100)
            
            customView.alpha = 1
            self.view.addSubview(customView)
        }
    }
    
    @objc func showDetails(_ sender: UIGestureRecognizer){
        
        let tapLocation = sender.location(in: self.mainTable)
        
        let indexPath = self.mainTable.indexPathForItem(at: tapLocation)
        print("\(indexPath?.row)")
        let wine = self.wineList.wineList[(indexPath?.row)! ]
        if let viewController = self.programmaticSegue(vcName: "FindMyWineDetailsViewController", storyBoard: "Main") as? FindMyWineDetailsViewController {
            
            viewController.wine = wine
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @objc func showWasWineAvailable(_ sender: UIGestureRecognizer){
        let tapLocation = sender.location(in: self.mainTable)
        
        let indexPath = self.mainTable.indexPathForItem(at: tapLocation)
        print("\(indexPath?.row)")
        let wine = self.wineList.wineList[(indexPath?.row)! ]
        if let viewController = self.programmaticSegue(vcName: "WasWineAvailableViewController", storyBoard: "Main") as? WasWineAvailableViewController {
            
            viewController.wine = wine
            viewController.retailer = retailer
            self.present(viewController, animated: true, completion: nil)
        }
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
        self.dismiss(animated: true, completion: nil)
        
        
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
    
    func doGoHome(){
         self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

