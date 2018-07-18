//
//  RateMyWineUnRatedController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/5/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit


class RateMyWineURatedCell: UITableViewCell {
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var lbl_Distance: UILabel!
    @IBOutlet var lbl_BusinessName: UILabel!
    @IBOutlet var lbl_Address: UILabel!
    @IBOutlet var lbl_Date: UILabel!
    @IBOutlet var btn_RateThisWine: UIButton!
    
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

class RateMyWineUnRatedController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource
{
    
    @IBOutlet var mainTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.AppColors.purple
        
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.backgroundColor = UIColor.AppColors.dark_purple
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RateMyWineURatedCell", for: indexPath) as! RateMyWineURatedCell
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
