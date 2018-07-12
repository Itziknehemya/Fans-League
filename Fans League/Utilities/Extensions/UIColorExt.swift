//
//  UIColorExt.swift
//  Fans League
//
//  Created by itzik nehemya on 11/07/2018.
//  Copyright © 2018 Nehemya. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static var flRed: UIColor {
        return UIColor(hexString:"#E61625")
    }
    static var flBlue: UIColor {
        return UIColor(hexString:"#0B4891")
    }
    static var flYellow: UIColor {
        return UIColor(hexString:"#FDCA2F")
    }
    static var flGreen: UIColor {
        return UIColor(hexString:"#297C16")
    }

    convenience init(hexString: String) {
        let hexString:NSString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
        let scanner = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}
