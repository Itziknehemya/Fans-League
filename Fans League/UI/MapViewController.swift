//
//  MapViewController.swift
//  Fans League
//
//  Created by itzik nehemya on 11/07/2018.
//  Copyright © 2018 Nehemya. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: FLViewController {
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var letsGoButton: UIButton!
    @IBOutlet weak var notYetButton: UIButton!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    var googleMapView: GMSMapView?
    
    let GOOGLE_API_KEY: String  = "AIzaSyB_c581UP3DQSbWh_dmeCPF7RoaG0dQhzI"
    
    let PT: Int = 13
    
    var netanyaStadium: CLLocationCoordinate2D {
        return LocationManager.shared.netanyaStadium
    }
    
    var currentUserLocation: CLLocationCoordinate2D? {
        return LocationManager.shared.userLocation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLetsGoButton()
        configNotYetButton()
        configCarImageView()
        configPointsLabel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configGoogleMaps()
        configDistanceLabelAndPtCount()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configGoogleMaps() {
        GMSServices.provideAPIKey(GOOGLE_API_KEY)

        let cameraPosition = GMSCameraPosition.camera(withLatitude: netanyaStadium.latitude, longitude: netanyaStadium.longitude, zoom: 10)
        
        googleMapView = GMSMapView.map(withFrame: CGRect(origin: CGPoint.zero, size: self.mapView.bounds.size), camera: cameraPosition)
        
        googleMapView?.isMyLocationEnabled = false
        googleMapView?.tintColor = fanColor
        
        let netanyaStadiumLocation = CLLocationCoordinate2D(latitude: netanyaStadium.latitude, longitude: netanyaStadium.longitude)
        
        let myLocationMarker = GMSMarker(position: currentUserLocation!)
        myLocationMarker.title = "My location"
        myLocationMarker.map?.tintColor = fanColor
        myLocationMarker.map = googleMapView
        
        let myLocationMarkerImage = #imageLiteral(resourceName: "dot").withRenderingMode(.alwaysTemplate)
        let myLocationImageView = UIImageView(image: myLocationMarkerImage)
        myLocationImageView.frame.size = CGSize(width: 20, height: 20)
        myLocationImageView.contentMode = .scaleAspectFit
        myLocationMarker.iconView = myLocationImageView
        
        
        let destinationMarker = GMSMarker(position: netanyaStadiumLocation)
        destinationMarker.title = "Netanya stadium"
        destinationMarker.map?.tintColor = fanColor
        destinationMarker.map = googleMapView
        
        let destinationMarkerImage = #imageLiteral(resourceName: "location_icon").withRenderingMode(.alwaysTemplate)
        let destinationImageView = UIImageView(image: destinationMarkerImage)
        destinationImageView.frame.size = CGSize(width: 20, height: 20)
        destinationImageView.contentMode = .scaleAspectFit
        destinationMarker.iconView = destinationImageView
        
        
        
        let path = GMSMutablePath()
        path.add(currentUserLocation!)
        path.add(netanyaStadium)
        
        let singleLine = GMSPolyline.init(path: path)
        singleLine.strokeWidth = 6.0
        singleLine.strokeColor = fanColor
        singleLine.map = googleMapView
        
        self.mapView.addSubview(googleMapView!)
    }
    
    func configDistanceLabelAndPtCount() {
        let distance = LocationManager.shared.getDistance(from: currentUserLocation!, to: netanyaStadium)
        distanceLabel.text = "Estimated distance \(distance) km"
        animatePointsLabel(to: distance * PT)
    }
    
    func animatePointsLabel(to endValue: Int) {
        let duration: Double = 2.0
        DispatchQueue.global().async {
            for i in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    self.pointsLabel.text = "+\(i) pt."
                }
            }
        }
    }
    
    func configPointsLabel() {
        pointsLabel.setBorder(borderWidth: 2)
        pointsLabel.textColor = fanColor
        pointsLabel.makeRoundedCorners(pointsLabel.frame.width/2)
    }
    
    func configCarImageView() {
        carImageView.image = #imageLiteral(resourceName: "car_icon").withRenderingMode(.alwaysTemplate)
        carImageView.tintColor = fanColor
    }
    
    func configLetsGoButton() {
        letsGoButton.backgroundColor = fanColor
        letsGoButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    func configNotYetButton() {
        notYetButton.setTitleColor(fanColor, for: .normal)
        notYetButton.setBorder()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configNavigationBar(navigationBarTitle: "I'm on my way!", leftBarButtonItem: leftBackBarButtonItem, isPopGestureEnabled: true)
    }
    
    @IBAction func letsGoButtonPressed(_ sender: UIButton) {
        showAlertController()
    }
    
    @IBAction func notYetButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlertController() {
        let alertController: UIAlertController = UIAlertController()
        
        alertController.addAction(UIAlertAction(title: "Open with waze", style: UIAlertActionStyle.default, handler: { [weak self] (alertAction) in
            guard let strongSelf = self else { return }
            strongSelf.openWaze(location: strongSelf.netanyaStadium)
        }))
        alertController.addAction(UIAlertAction(title: "Open with google maps", style: UIAlertActionStyle.default, handler: { [weak self] (alertAction) in
            guard let strongSelf = self else { return }
            strongSelf.openGoogleMaps(location: strongSelf.netanyaStadium)
        }))
        alertController.addAction(UIAlertAction(title: "Open with maps", style: UIAlertActionStyle.default, handler: { [weak self] (alertAction) in
            guard let strongSelf = self else { return }
            strongSelf.openMaps(location: strongSelf.netanyaStadium)
        }))
        alertController.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil))
        alertController.show(inViewController: self)
        
    }
    
    func openGoogleMaps(location : CLLocationCoordinate2D) {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            let url = "comgooglemaps://?saddr=&daddr=\(location.latitude),\(location.longitude)&directionsmode=driving"
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        } else {
            print("Can't use comgooglemaps://")
        }
    }
    
    func openWaze(location : CLLocationCoordinate2D) {
        if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {
            let url: String = "waze://?ll=\(location.latitude),\(location.longitude)&navigate=yes"
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        }
        else {
            UIApplication.shared.open(URL(string: "http://itunes.apple.com/us/app/id323229106")!, options: [:], completionHandler: nil)
        }
    }
    
    func openMaps(location : CLLocationCoordinate2D) {
        let url = "http://maps.apple.com/maps?saddr=\(currentUserLocation!.latitude),\(currentUserLocation!.longitude)&daddr=\(location.latitude),\(location.longitude)"
        UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
    }
}
