//
//  vwStretchSwipe.swift
//  SweetSpot Beta
//
//  Created by Iziah Reid on 8/17/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
protocol vwStretchSwipeDelegate {
    func vwStretchSwipe_SwipeRight()
}
class vwStretchSwipe: UIView {
    
    @IBOutlet weak var vwArrow: UIView!
    @IBOutlet weak var progressBar: ProgressBar!
    
    var delegate:vwStretchSwipeDelegate?
    @IBOutlet weak var lblInstructions: UILabel!
    
    override func layoutSubviews() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.addGestureRecognizer(swipeRight)
        let arrow = UIImage(named: "gray_arrow.png")
        
        vwArrow.backgroundColor = UIColor(patternImage: arrow!)
        
        progressBar.isHidden = true
        
    }
    
    
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                let point = gesture.location(in: progressBar)
                progressBar.progress = 1
                layoutIfNeeded()
                delegate?.vwStretchSwipe_SwipeRight()
                print("Swiped righkkt")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
}
