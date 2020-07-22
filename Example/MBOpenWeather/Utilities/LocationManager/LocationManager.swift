//
//  LocationManager.swift
//  MBOpenWeather_Example
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func locationManagerDidReceiveLocation(currentLocation: CLLocation)
    func locationManagerDidFailWithError(error: NSError)
}

public class LocationManager: NSObject {
    
    public static let shared = LocationManager()

    var clManager: CLLocationManager?
    var lastLocation: CLLocation?
    var delegate: LocationManagerDelegate?

    private override init() {
        super.init()
        
        self.clManager = CLLocationManager()
        guard let locationManager = self.clManager else {
            return
        }
        
        locationManager.delegate = self
    }
    
    func startUpdatingLocation() {
        print("Starting Location Updates")
        self.clManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.clManager?.stopUpdatingLocation()
    }
    
    func requestLocationUpdates() {
        let permissionStatus = CLLocationManager.authorizationStatus();
        switch permissionStatus {
        case .notDetermined:
            self.clManager?.requestWhenInUseAuthorization()
            break
        default:
            startUpdatingLocation()
            break
        }
    }
            
    // Private function
    private func updateLocation(currentLocation: CLLocation){
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.locationManagerDidReceiveLocation(currentLocation: currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: NSError) {
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.locationManagerDidFailWithError(error: error)
    }
}

extension LocationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        // singleton for get last location
        self.lastLocation = location

        // use for real time update location
        updateLocation(currentLocation: location)
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted,.denied,.notDetermined:
            print("error")
            break
        default:
            startUpdatingLocation()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        updateLocationDidFailWithError(error: error as NSError)
    }
}
