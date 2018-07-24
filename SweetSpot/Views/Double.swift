//
//  Double.swift
//  SweetSpot
//
//  Created by Iziah Reid on 7/20/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import Foundation
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
