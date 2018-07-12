//
//  FanColor.swift
//  Fans League
//
//  Created by itzik nehemya on 11/07/2018.
//  Copyright © 2018 Nehemya. All rights reserved.
//

import Foundation
import UIKit

class FanColor {
    
    struct Keys {
        static let FAN_COLOR_NUMBER = "fanColorNumber"
    }
    
    static let shared = FanColor()
    
    init() {
        fanColor = loadFanColor
    }
    
    var fanColor: UIColor?
    
    private var colorNumber: Int?

    let colors: [UIColor] = [UIColor.flRed, UIColor.flGreen, UIColor.flBlue, UIColor.flYellow]
    
    private func saveFanColor() {
        UserDefaults.save(value: colorNumber ?? 0, forKey: Keys.FAN_COLOR_NUMBER)
    }
    
    private var loadFanColor: UIColor {
        guard let colorNumber = UserDefaults.load(key: Keys.FAN_COLOR_NUMBER) as? Int else { return colors[0] }
        self.colorNumber = colorNumber
        return colors[colorNumber]
    }
    
    func changeFanColor() {
        let randomInt = Int(arc4random_uniform(UInt32(colors.count)) )
        guard randomInt != colorNumber else { changeFanColor(); return }
        colorNumber = randomInt
        fanColor = colors[randomInt]
        saveFanColor()
    }
}
