//
//  UIViewExt.swift
//  Fans League
//
//  Created by itzik nehemya on 11/07/2018.
//  Copyright © 2018 Nehemya. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setBorder(with color: UIColor = FanColor.shared.fanColor ?? FanColor.shared.colors[0], borderWidth: CGFloat = 1.0) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func makeRoundedCorners(_ radius: CGFloat = 5) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func fadeIn(duration: TimeInterval = TimeInterval(0.3)) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        })
    }
    func fadeOut(duration: TimeInterval = TimeInterval(0.3)) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        })
    }

}
