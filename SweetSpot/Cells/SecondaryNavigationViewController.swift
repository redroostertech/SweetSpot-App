//
//  SecondaryNavigationViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/3/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

class SecondaryNavigationViewController: UIViewController {
    
    @IBOutlet var btn_Back: UIButton!
    @IBOutlet var btn_Help: UIButton!
    @IBOutlet var btn_Profile: UIButton!
    @IBOutlet var lbl_Title: UILabel!
    
    var delegate: NavDelegate?
    var titleForView: String? {
        didSet {
            self.lbl_Title.text = titleForView ?? ""
        }
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .clear
    }
    
    @IBAction func back(_ sender: UIButton) {
        print("SecondaryNavigationViewController  back")
        self.delegate?.doDismiss()
    }
    
    @IBAction func help(_ sender: UIButton) {
        self.delegate?.doGoToHelp()
    }
    
    @IBAction func profile(_ sender: UIButton) {
        self.delegate?.doGoToProfile()
    }

}
