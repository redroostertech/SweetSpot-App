//
//  FindMyWineViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/4/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import DropDown

class FindMyWineFirstCell: UITableViewCell {
    @IBOutlet var lbl_Title: UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()
        lbl_Title.textColor = UIColor.AppColors.beige
    }
}

class FindMyWineCell: UITableViewCell {
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var lbl_Distance: UILabel!
    @IBOutlet var lbl_BusinessName: UILabel!
    @IBOutlet var lbl_Address: UILabel!
    @IBOutlet var btn_GoTo: UIButton!
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

class FindMyWineViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource
{

    @IBOutlet var mainTable: UITableView!
    @IBOutlet var navigationViewContainer: UIView!
    @IBOutlet var text_Address: UITextField!
    @IBOutlet var text_Search: UITextField!
    @IBOutlet var text_Retailers: UITextField!
    @IBOutlet var text_Distance: UITextField!
    
    var navigation: SecondaryNavigationViewController!
    let locationManager = CLLocationManager()
    var retailerList:RetailerList = RetailerList(JSONString: "{}")!
    var retailerTypeList:RetailerTypeList = RetailerTypeList(JSONString:"{}")!
    var retailerDistanceList:RetailerDistanceList = RetailerDistanceList(JSONString:"{}")!
    var picker: UIPickerView?
    var dropDownType: Int = 0
    
    var selectedRetailer = 0
    var selectedDistance = 0
    
    var selectedRetailIndex = -1
    let ddRetailerTypes = DropDown()
    let ddRetailerDistances = DropDown()
    
    let indicatorHolder = ActivityIndicatorHolder()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.AppColors.purple
        
        navigation = SecondaryNavigationViewController()
        addChildViewController(navigation)
        navigationViewContainer.addSubview(navigation.view)
        didMove(toParentViewController: navigation)
        navigation.delegate = self
        navigation.titleForView = "FIND MY WINE"
        
        self.text_Search.textColor = UIColor.AppColors.beige
        self.text_Search.backgroundColor = UIColor.AppColors.dark_purple
         self.text_Search.delegate = self
        
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
        self.text_Address.delegate = self
        
        
        let retailersRightInputImage = UIImage(named: "dropDownArrow")
        let retailersRightInputImageView = UIImageView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: 32,
                                                            height: self.text_Retailers.frame.height))
        retailersRightInputImageView.image = retailersRightInputImage
        retailersRightInputImageView.contentMode = .center
        self.text_Retailers.rightViewMode = .always
        self.text_Retailers.textColor = UIColor.AppColors.beige
        self.text_Retailers.rightView = retailersRightInputImageView
        self.text_Retailers.delegate = self
        
        let distanceRightInputImage = UIImage(named: "dropDownArrow")
        let distanceRightInputImageView = UIImageView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: 32,
                                                            height: self.text_Distance.frame.height))
        distanceRightInputImageView.image = distanceRightInputImage
        distanceRightInputImageView.contentMode = .center
        self.text_Distance.rightViewMode = .always
        self.text_Distance.textColor = UIColor.AppColors.beige
        self.text_Distance.rightView = distanceRightInputImageView
        self.text_Distance.delegate = self
        self.text_Distance.text = "Any Distance"
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.backgroundColor = UIColor.AppColors.dark_purple
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: .UIKeyboardWillHide , object: nil)

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.requestLocation()
        loadList(list_id:2)
        loadList(list_id:1)
        self.loadMainTable()
        //indicatorHolder.showActivityIndicator(uiView: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        
    }
   
    
    func loadList(list_id:Int){
        var action = ""
        switch(list_id){
        case 1:
            action = "getRetailTypes"
             self.ddRetailerTypes.dataSource = []
            break
        case 2:
            action = "getRetailDistances"
            self.ddRetailerDistances.dataSource = []
            break
    
        default:
            break
        }
        let parameters: Parameters = ["action": action]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseString { response in
            print("Response: \(response.result.value!)")
            switch(list_id){
            case 1:
                self.retailerTypeList = RetailerTypeList(JSONString: response.result.value!)!
                for retailerType in self.retailerTypeList.retailertypeList{
                    
                   self.ddRetailerTypes.dataSource.append(retailerType.getRetailertypename())
                }
                if(self.retailerTypeList.retailertypeList.count > 0){
                    self.selectedRetailer = 7
                    self.text_Retailers.text = "All Retailers"
                    self.ddRetailerTypes.anchorView = self.text_Retailers // UIView or UIBarButtonItem
                    //self.fulfillmentDropdown.dataSource = self.fulfillmentTypes
                    self.ddRetailerTypes.selectionAction = { [unowned self] (index: Int, item: String) in
                        print("Selected item: \(item) at index: \(index)")
                        self.text_Retailers.text = item
                        self.selectedRetailer = self.retailerTypeList.retailertypeList[index].getRetailertypeid()
                        self.loadMainTable()
                    }
                }
                
                break
            case 2:
                self.retailerDistanceList = RetailerDistanceList(JSONString: response.result.value!)!
                for retailerDistance in self.retailerDistanceList.retailerdistanceList{
                    
                    self.ddRetailerDistances.dataSource.append(retailerDistance.getDistancename())
                }
                if(self.retailerDistanceList.retailerdistanceList.count > 0){
                    self.selectedDistance = self.retailerDistanceList.retailerdistanceList[0].getRetailerdistanceid()
                    self.text_Distance.text = self.retailerDistanceList.retailerdistanceList[0].getDistancename()
                    self.ddRetailerDistances.anchorView = self.text_Distance // UIView or UIBarButtonItem
                    //self.fulfillmentDropdown.dataSource = self.fulfillmentTypes
                    self.ddRetailerDistances.selectionAction = { [unowned self] (index: Int, item: String) in
                        print("Selected item: \(item) at index: \(index)")
                        self.text_Distance.text = item
                        self.selectedDistance = self.retailerDistanceList.retailerdistanceList[index].getRetailerdistanceid()
                        self.loadMainTable()
                    }
                }
                
                break
           
            default:
                break
            }
            
            
        } //alamofire
    }
    
    func loadMainTable(){
        let address = text_Address.text!
        let radius = text_Distance.text!
        let retail_type = text_Retailers.text!
        var retail_name = text_Search.text!
        if retail_name == "Search For A Retailer By Name"{
            retail_name = ""
        }
        print("retail_name \(retail_name)")
        let parameters: Parameters = ["action": "getRetailListByAddress",
                                      "address":address,
                                      "retail_type_id":selectedRetailer,
                                      "retail_distance_id":selectedDistance,
                                      "retail_name":retail_name
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            if response.result.value == nil{
                print("error from server returning nil")
                self.retailerList = RetailerList(JSONString: "{}")!
                self.mainTable.reloadData()
                return
            }
            let jsonValues = response.result.value as! [String:Any]
            
            let status = jsonValues["status"] as? Int
            if status != 1{
                print("error from server: \(jsonValues["message"])")
                self.retailerList = RetailerList(JSONString: "{}")!
                self.mainTable.reloadData()
                return
            }
            let data = jsonValues["data"] as! [String:Any]
            if let theJSONData = try? JSONSerialization.data( withJSONObject: data, options: []) {
                let theJSONText = String(data: theJSONData,
                                         encoding: .ascii)
                print("JSON string = \(theJSONText!)")
                
                self.retailerList = RetailerList(JSONString: theJSONText!)!
                self.mainTable.reloadData()
            }
        }
    }

   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.retailerList.retailerList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath)
            cell.backgroundColor = .clear
            return cell
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FindMyWineCell
        cell.backgroundColor = .clear
        if indexPath.row - 1 >= 0{
            let retailer = retailerList.retailerList[indexPath.row - 1]
            cell.lbl_BusinessName.text = retailer.getRetailername()
            cell.lbl_Address.text = retailer.getAddressline1()
            if let strDistance = retailer.distance{
                if let distance = Double(strDistance){
                    cell.lbl_Distance.text = "\(distance.rounded(toPlaces: 2)) miles"
                }
            }
            var image_url = "http://52.15.191.207/images/wine_aisle.jpg"
            //
            switch(retailer.getRetailertypeid()){
            case 1:
                image_url = "http://52.15.191.207/images/restaurant_wine.jpg"
                break
            case 2:
                image_url = "http://52.15.191.207/images/grocery_wine.jpeg"
                break
            case 3:
                image_url = "http://52.15.191.207/images/liquor_store_wine.jpg"
                break
            case 4:
                image_url = "http://52.15.191.207/images/hotel_wine.jpg"
                break
            case 5:
                image_url = "http://52.15.191.207/images/bar_wine.jpg"
                break
            case 6:
                image_url = "http://52.15.191.207/images/big_box_wine.jpg"
                break
            default:
                break
            }
            cell.mainImg.imageFromUrl(theUrl: image_url)
            cell.btn_GoTo.tag = indexPath.row - 1
            cell.btn_GoTo.addTarget(self, action: #selector(FindMyWineViewController.connected(sender:)), for: .touchUpInside)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 75
        }
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("didSelectRowAt \(indexPath.row) ")
        if indexPath.row - 1 >= 0{
            let retailer = retailerList.retailerList[indexPath.row - 1]
            selectedRetailIndex = indexPath.row - 1
            performSegue(withIdentifier: "segueWineDetails", sender: self)
        }
    }
    @objc func connected(sender: UIButton){
        selectedRetailIndex = sender.tag
        performSegue(withIdentifier: "segueWineDetails", sender: self)
    }
    //happens after the didSelectRow at
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueWineDetails"{
            
            let vc = segue.destination as! FindMyWineDetailsListViewController
             let retailer = retailerList.retailerList[selectedRetailIndex]
            
            vc.retailer = retailer
        }
    }
}


extension FindMyWineViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case text_Retailers:
            self.ddRetailerTypes.show()
            self.view.endEditing(true)
            break
        case text_Distance:
            self.ddRetailerDistances.show()
            self.view.endEditing(true)
            break
        default:
            break
        }
    }
    
   
     @objc func keyboardWillHide(_ notification: NSNotification) {
        print("Keyboard will hide!")
        self.loadMainTable()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == self.text_Search{
            self.loadMainTable()
        }
        if textField == self.text_Address{
            self.loadMainTable()
        }
        return true
    }
}



extension FindMyWineViewController: NavDelegate {
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

extension FindMyWineViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            print("\(lat),\(long)")
            getAddressFromLatLon(pdblLatitude:"\(lat)", withLongitude: "\(long)")
            
        } else {
            print("No coordinates")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
//                    print(pm.country)
//                    print(pm.locality)
//                    print(pm.subLocality)
//                    print(pm.thoroughfare)
//                    print(pm.postalCode)
//                    print(pm.region)
//                    print(pm.subThoroughfare)
                    var addressString : String = ""

                    
                    if pm.subThoroughfare != nil{
                        addressString = addressString + pm.subThoroughfare! + " "
                    }
                    if pm.thoroughfare != nil{
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil{
                        addressString = addressString + pm.locality! + " "
                    }
                    if pm.administrativeArea != nil{
                        addressString = addressString + pm.administrativeArea! + ", "
                    }
                    if pm.postalCode != nil{
                        addressString = addressString + pm.postalCode!
                    }
                    //print(addressString)
                    self.text_Address.text = addressString
                    if AppConstants.IS_SIMULATOR{
                        self.text_Address.text = "384 northyards blvd nw, atlanta, ga 30313"
                    }
                   //self.indicatorHolder.hideActivityIndicator(uiView: self.view)
                    self.loadMainTable()
                }
        })
        
    }
    
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?) -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                    // An error occurred during geocoding.
                    completionHandler(nil)
                     //self.indicatorHolder.hideActivityIndicator(uiView: self.view)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
            //self.indicatorHolder.hideActivityIndicator(uiView: self.view)
        }
    }
    
}
