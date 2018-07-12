//
//  LocationManager.swift
//  Fans League
//
//  Created by itzik nehemya on 11/07/2018.
//  Copyright © 2018 Nehemya. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    let netanyaStadium: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 32.294131, longitude: 34.865815)
    
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    
    var userLocation: CLLocationCoordinate2D?
    
    var isLocationServicesEnabled: Bool {
        return CLLocationManager.authorizationStatus() != .denied && CLLocationManager.authorizationStatus() != .restricted
    }
    
    override init() {
        super.init()
        self.requestPermission()
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getUserLocation() {
        if isLocationServicesEnabled {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.userLocation = userLocation
        locationManager.stopUpdatingLocation()
    }
    
    /// Get distance between two points
    func getDistance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Int {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        let distance = from.distance(from: to)
        return Int(distance / 1000)
    }
}
