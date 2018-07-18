//
//  PrimaryNavigationViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/3/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

protocol NavDelegate {
    func doDismiss()
    func doGoToProfile()
    func doShowMenu()
    func doGoToHelp()
}
extension NavDelegate {
    func doDismiss() { }
    func doGoToProfile() { }
    func doShowMenu() { }
    func doGoToHelp() { }
}

class PrimaryNavigationViewController: UIViewController {

    @IBOutlet var btn_Menu: UIButton!
    @IBOutlet var btn_Help: UIButton!
    @IBOutlet var btn_Profile: UIButton!
    
    var delegate: NavDelegate?
    
    override func viewDidLoad() {
        self.view.backgroundColor = .clear
    }
    @IBAction func menu(_ sender: UIButton) {
        self.delegate?.doShowMenu()
    }

    @IBAction func help(_ sender: UIButton) {
        self.delegate?.doGoToHelp()
    }
    
    @IBAction func profile(_ sender: UIButton) {
        self.delegate?.doGoToProfile()
    }
}
