//
//  ShareToSocialViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/6/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Social
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
        
        var tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        tweetShare.setInitialText(" Check out this new, innovative way to find the perfect wine for you at any place wine is sold.  Sign up for the SweetSpot Beta program at www.sweetspotwine.com")
        self.present(tweetShare, animated: true, completion: nil)
//        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
//
//
//
//        } else {
//
//            var alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to post.", preferredStyle: UIAlertControllerStyle.alert)
//
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//
//            self.present(alert, animated: true, completion: nil)
//        }
       
    }
    
    @IBAction func twitter(_ sender: UIButton) {
        
        var tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        tweetShare.setInitialText(" Check out this new, innovative way to find the perfect wine for you at any place wine is sold.  Sign up for the SweetSpot Beta program at www.sweetspotwine.com")
        self.present(tweetShare, animated: true, completion: nil)
//        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
//
//            var tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//            tweetShare.setInitialText(" Check out this new, innovative way to find the perfect wine for you at any place wine is sold.  Sign up for the SweetSpot Beta program at www.sweetspotwine.com")
//            self.present(tweetShare, animated: true, completion: nil)
//
//        } else {
//
//            var alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to tweet.", preferredStyle: UIAlertControllerStyle.alert)
//
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//
//            self.present(alert, animated: true, completion: nil)
//        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true,
                completion: nil)
    }
}
