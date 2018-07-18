//
//  AttributedString+Extensions.swift
//  PopViewers
//
//  Created by Michael Westbrooks II on 4/25/18.
//  Copyright © 2018 MVPGurus. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont.boldSystemFont(ofSize: 14)]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func color(_ text: String, color: UIColor) -> NSMutableAttributedString {
        let attrs = [NSAttributedStringKey.foregroundColor: color]
        let coloredString = NSMutableAttributedString(string:text, attributes: attrs)
        append(coloredString)
        
        return self
    }
    
    @discardableResult func normal(_ text:String)->NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }
}
