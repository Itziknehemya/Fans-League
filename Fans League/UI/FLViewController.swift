//
//  FLViewController.swift
//  Fans League
//
//  Created by itzik nehemya on 11/07/2018.
//  Copyright © 2018 Nehemya. All rights reserved.
//

import UIKit

class FLViewController: UIViewController, UIGestureRecognizerDelegate {
    
    lazy var leftBackBarButtonItem: UIBarButtonItem = {
        let leftBackBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon") ,landscapeImagePhone: nil, style: UIBarButtonItemStyle.plain, target: self, action: #selector(popViewControllerPressed(_:)))
        leftBackBarButtonItem.tintColor = UIColor.white
        return leftBackBarButtonItem
    }()
    
    var fanColor: UIColor {
        return FanColor.shared.fanColor ?? FanColor.shared.colors[0]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBarIsHidden()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configNavigationBar(navigationBarTitle: String? = "", leftBarButtonItem: UIBarButtonItem? = nil, rightBarButtonItem: UIBarButtonItem? = nil, rightBarButtonItems: [UIBarButtonItem]? = nil, isPopGestureEnabled: Bool = true) {
        
        navigationController?.navigationBar.topItem?.title = navigationBarTitle?.capitalized
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: .medium)]
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = FanColor.shared.fanColor
        navigationController?.navigationBar.topItem?.leftBarButtonItem = leftBarButtonItem
        if rightBarButtonItems != nil {
            navigationController?.navigationBar.topItem?.rightBarButtonItems = rightBarButtonItems
        } else {
            navigationController?.navigationBar.topItem?.rightBarButtonItems = nil
            navigationController?.navigationBar.topItem?.rightBarButtonItem = rightBarButtonItem
        }
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = isPopGestureEnabled
    }
    
    @objc func popViewControllerPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configNavigationBarIsHidden() {
        navigationController?.setNavigationBarHidden(self is MainViewController, animated: true)
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (alert) in
            self?.goToSettings()
        }))
        
        self.present(alert, animated: true)
    }
    
    @discardableResult
    func goToSettings(withUrl: String? = nil) -> Bool {
        if let openSettingsUrl = URL(string: withUrl ?? UIApplicationOpenSettingsURLString), UIApplication.shared.canOpenURL(openSettingsUrl) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(openSettingsUrl, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(openSettingsUrl)
            }
            return true
        }
        return false
    }

}
