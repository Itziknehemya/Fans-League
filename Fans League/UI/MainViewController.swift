//
//  MainViewController.swift
//  Fans League
//
//  Created by itzik nehemya on 11/07/2018.
//  Copyright © 2018 Nehemya. All rights reserved.
//

import UIKit

class MainViewController: FLViewController {

    @IBOutlet weak var carButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var fanColorButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var fansLeague: UILabel!
    
    lazy var confettiEffects: ConfettiEffects = {
       let confettiEffects = ConfettiEffects()
        confettiEffects.alpha = 0
        return confettiEffects
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        
        if LocationManager.shared.isLocationServicesEnabled {
            LocationManager.shared.getUserLocation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Utils.stopSound()
    }
    
    func configViews() {
        configLabels()
        configCarViews()
        configFanColorButton()
        configNavigationBar()
        configIconImageView()
    }
    
    func configLabels() {
        welcomeLabel.textColor = fanColor
        fansLeague.textColor = fanColor
    }
    
    func configCarViews() {
        carButton.tintColor = fanColor
        carButton.setBorder()
        
        carImageView.image = #imageLiteral(resourceName: "car_icon").withRenderingMode(.alwaysTemplate)
        carImageView.tintColor = fanColor
    }
    
    func configIconImageView() {
        iconImageView.image = #imageLiteral(resourceName: "icon").withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = fanColor
    }
    
    func configFanColorButton() {
        fanColorButton.setTitleColor(UIColor.white, for: .normal)
        fanColorButton.backgroundColor = fanColor
    }
    
    @IBAction func carButtonPressed(_ sender: UIButton) {
        LocationManager.shared.getUserLocation()
        guard LocationManager.shared.isLocationServicesEnabled && LocationManager.shared.userLocation != nil else { alert(title: "We needs your location!", message: "Go to settings!"); return }
        
        let mapViewController: MapViewController = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    @IBAction func fanColorButtonPressed(_ sender: UIButton) {
        FanColor.shared.changeFanColor()
        configConfettiEffects()
        configViews()
    }
    
    func configConfettiEffects() {
        confettiEffects.frame = self.view.frame
        self.view.insertSubview(confettiEffects, at: 0)
        confettiEffects.showAnimation()
        confettiEffects.fadeIn()
        Utils.playSound("Sports", fileType: "mp3")
    }
}
