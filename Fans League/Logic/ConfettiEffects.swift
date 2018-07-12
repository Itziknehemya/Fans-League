//
//  ConfettiEffects.swift
//  Fans League
//
//  Created by itzik nehemya on 12/07/2018.
//  Copyright © 2018 Nehemya. All rights reserved.
//

import Foundation
import UIKit

class ConfettiEffects: UIView {
    
    var emitter = CAEmitterLayer()
    
    var images:[UIImage] = [#imageLiteral(resourceName: "Box"), #imageLiteral(resourceName: "Triangle"), #imageLiteral(resourceName: "Circle"),#imageLiteral(resourceName: "Spiral")]
    
    var velocities:[Int] = [100,90,150,200]

    func showAnimation() {
        emitter.emitterPosition = CGPoint(x: self.frame.size.width / 2, y: -10)
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterSize = CGSize(width: self.frame.size.width, height: 2.0)
        emitter.emitterCells = generateEmitterCells()
        self.layer.addSublayer(emitter)
    }
    
    private func generateEmitterCells() -> [CAEmitterCell] {
        var cells:[CAEmitterCell] = [CAEmitterCell]()
        for index in 0..<16 {
            
            let cell = CAEmitterCell()
            
            cell.birthRate = 4.0
            cell.lifetime = 14.0
            cell.lifetimeRange = 0
            cell.velocity = CGFloat(getRandomVelocity())
            cell.velocityRange = 0
            cell.emissionLongitude = CGFloat(Double.pi)
            cell.emissionRange = 0.5
            cell.spin = 3.5
            cell.spinRange = 0
            cell.color = FanColor.shared.fanColor?.cgColor
            cell.contents = getNextImage(i: index)
            cell.scaleRange = 0.25
            cell.scale = 0.1
            
            cells.append(cell)
            
        }
        return cells
    }
    
    private func getRandomVelocity() -> Int {
        return velocities[getRandomNumber()]
    }
    
    private func getRandomNumber() -> Int {
        return Int(arc4random_uniform(4))
    }
    
    private func getNextImage(i:Int) -> CGImage {
        return images[i % 4].cgImage!
    }
}
