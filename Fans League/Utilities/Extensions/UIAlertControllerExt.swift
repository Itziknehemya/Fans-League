//
//  UIAlertControllerExt.swift
//  Fans League
//
//  Created by itzik nehemya on 11/07/2018.
//  Copyright © 2018 Nehemya. All rights reserved.
//

import Foundation
import  UIKit

extension UIAlertController {
    
    func show(inViewController viewController: UIViewController) {
        self.modalPresentationStyle = .popover
        if let presenter = self.popoverPresentationController {
            presenter.sourceView = viewController.view
        }
        viewController.present(self, animated: true, completion: nil)
    }
}
