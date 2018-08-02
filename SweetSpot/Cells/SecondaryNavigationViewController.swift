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
    
    @IBOutlet weak var btn_House: UIButton!
    var delegate: NavDelegate?
    var titleForView: String? {
        didSet {
            self.lbl_Title.text = titleForView ?? ""
        }
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .clear
    }
    
    
    @IBAction func btnHouse_Click(_ sender: Any) {
        self.delegate?.doGoHome()
        //self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
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
