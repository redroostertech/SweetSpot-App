//
//  Bundle.swift
//  SweetSpot
//
//  Created by Iziah Reid on 7/18/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import Foundation
extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var releaseVersionNumberPretty: String {
        return "v\(releaseVersionNumber ?? "1.0.0")"
    }
}
