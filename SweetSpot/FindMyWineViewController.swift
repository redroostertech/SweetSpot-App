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
        loadList(list_id:1)
        loadList(list_id:2)
    }
    func presentPicker(_ textField: UITextField) {
        self.picker = UIPickerView()
        self.picker?.delegate = self
        self.picker?.dataSource = self
        self.picker?.reloadAllComponents()
        textField.inputView = self.picker
    }
    
    func loadList(list_id:Int){
        var action = ""
        switch(list_id){
        case 1:
            action = "getRetailTypes"
            break
        case 2:
            action = "getRetailDistances"
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
                
                break
            case 2:
                self.retailerDistanceList = RetailerDistanceList(JSONString: response.result.value!)!
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
        let parameters: Parameters = ["action": "getRetailListByAddress",
                                      "address":address,
                                      "retail_type_id":selectedRetailer,
                                      "retail_distance_id":selectedDistance
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            if response.result.value == nil{
                return
            }
            let jsonValues = response.result.value as! [String:Any]
            
            let status = jsonValues["status"] as? Int
            if status != 1{
                print("error from server: \(jsonValues["message"])")
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

    override func viewDidAppear(_ animated: Bool) {
        locationManager.requestLocation()
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
            if let distance = retailer.distance{
                cell.lbl_Distance.text = "\(distance)"
            }
            let image_url = retailer.getRetailerimageurl()
            if image_url.isBlank{
                 cell.mainImg.imageFromUrl(theUrl: "http://52.15.191.207/images/wine_aisle.jpg")
                cell.mainImg.contentMode = .scaleAspectFill
                cell.mainImg.clipsToBounds = true
            }else{
                cell.mainImg.imageFromUrl(theUrl: image_url)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 75
        }
        return 150
    }
}


extension FindMyWineViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case text_Retailers:
            self.presentPicker(textField)
            self.dropDownType = 1
            break
        case text_Distance:
            self.dropDownType = 2
            self.presentPicker(textField)
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

extension FindMyWineViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        let dropDownType = self.dropDownType
        switch(dropDownType){
        case 1:
            return retailerTypeList.retailertypeList.count
            
        case 2:
            return retailerDistanceList.retailerdistanceList.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch(dropDownType){
        case 1:
            return  retailerTypeList.retailertypeList[row].getRetailertypename()
        case 2:
            return  retailerDistanceList.retailerdistanceList[row].getDistancename()
            
        default:
            return ""
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //find the object at row and set the corresponding variable value (marital = 1, gender = 1, etc...)
        switch(dropDownType){
        case 1:
            self.selectedRetailer = retailerTypeList.retailertypeList[row].getRetailertypeid()
            self.text_Retailers.text = retailerTypeList.retailertypeList[row].getRetailertypename()
            self.loadMainTable()
            break
        case 2:
            self.selectedDistance = retailerDistanceList.retailerdistanceList[row].getRetailerdistanceid()
            self.text_Distance.text = retailerDistanceList.retailerdistanceList[row].getDistancename()
            self.loadMainTable()
            break
        
        default:
            break
        }
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
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
    
}
