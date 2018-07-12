//
//  Utils.swift
//  Fans League
//
//  Created by itzik nehemya on 12/07/2018.
//  Copyright © 2018 Nehemya. All rights reserved.
//

import Foundation
import AVFoundation

/// Dispatches the block after specified delay
public func runBlockAfterDelay(afterDelay seconds: Double, sync: Bool = false, onQueue: DispatchQueue = DispatchQueue.main, block: @escaping ()->()) {
    guard seconds > 0 else {
        onQueue.async {
            block()
        }
        return
    }
    
    let delayTime = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC) // 2 seconds delay before retry
    if sync {
        onQueue.asyncAfter(deadline: delayTime, execute: {
            onQueue.sync {
                block()
            }
        })
    } else {
        onQueue.asyncAfter(deadline: delayTime, execute: block)
    }
}

class Utils {
    static fileprivate var audioPlayer: AVAudioPlayer?
    
    static func playSound(_ fileName: String, fileType: String) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: fileType) else { return }
        
        let url = URL(fileURLWithPath: path)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try audioPlayer = AVAudioPlayer(contentsOf: url)    // Construct player with the given file
            audioPlayer?.prepareToPlay()                        // Load before playing
            audioPlayer?.play()                                 // Play it
        } catch let error {
            print("Failed to play audio file on path: \(path), error: \(error)")
        }
    }
    
    static func stopSound() {
        audioPlayer?.stop()
    }
}
