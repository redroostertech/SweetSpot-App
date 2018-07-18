//
//  FindMyWineDetailsListViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/4/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

class FindMyWineSponsoredCell: UITableViewCell {
    @IBOutlet var lbl_Title: UILabel!
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var lbl_WineName: UILabel!
    @IBOutlet var lbl_Address: UILabel!
    @IBOutlet var lbl_Price: UILabel!
    @IBOutlet var btn_GoTo: UIButton!
    @IBOutlet var btn_Details: UIButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        mainTable.backgroundColor = UIColor.AppColors.dark_purple
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FindMyWineSponsoredCell", for: indexPath) as! FindMyWineSponsoredCell
            cell.backgroundColor = .clear
            return cell
            
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FindMyWineRecommendedTitleCell", for: indexPath) as! FindMyWineRecommendedTitleCell
            cell.backgroundColor = .clear
            return cell
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindMyWineRecommendedCell", for: indexPath) as! FindMyWineRecommendedCell
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        }
        
        if indexPath.row == 1 {
            return 44
        }
        return 175
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
