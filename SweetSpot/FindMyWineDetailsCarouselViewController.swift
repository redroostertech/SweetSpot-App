//
//  FindMyWineDetailsCarouselViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/5/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FindMyWineCarouselCell", for: indexPath) as! FindMyWineCarouselCell
        cell.backgroundColor = .clear
        return cell
    }
    
}

extension FindMyWineDetailsCarouselViewController: NavDelegate {
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

