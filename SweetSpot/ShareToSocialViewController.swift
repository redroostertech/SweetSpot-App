//
//  ShareToSocialViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/6/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

class ShareToSocialViewController: UIViewController {
    
    @IBOutlet var btn_Facebook: UIButton!
    @IBOutlet var btn_Twitter: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.AppColors.purple.withAlphaComponent(0.9)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func facebook(_ sender: UIButton) {
        dismiss(animated: true,
                completion: nil)
    }
    
    @IBAction func twitter(_ sender: UIButton) {
        dismiss(animated: true,
                completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true,
                completion: nil)
    }
}
