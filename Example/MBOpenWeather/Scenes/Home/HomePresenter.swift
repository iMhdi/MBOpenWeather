//
//  HomePresenter.swift
//  MBOpenWeather_Example
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import UIKit
import CoreLocation
import MBOpenWeather

protocol HomePresenterProtocol: class {
    var view:HomeViewProtocol? { get set }
    
    func requestLocationUpdates()
}

class HomePresenter {
  
    // MARK: - Public variables
    weak var view:HomeViewProtocol?
  
    // MARK: - Private variables
  
    // MARK: - Initialization
    init(view:HomeViewProtocol) {
        self.view = view
        LocationManager.shared.delegate = self
    }
}

extension HomePresenter: HomePresenterProtocol {
        
    func requestLocationUpdates() {
        LocationManager.shared.requestLocationUpdates()
    }
}

extension HomePresenter: LocationManagerDelegate {
    func locationManagerDidReceiveLocation(currentLocation: CLLocation) {
        LocationManager.shared.stopUpdatingLocation()
        
        let lat = currentLocation.coordinate.latitude
        let lng = currentLocation.coordinate.longitude
        
        view?.startLoading()
        MBWeatherManager.shared.weatherInfo(forLatitude: lat, longitude: lng, withSuccess: { weatherInfo in
            self.view?.stopLoading()
            self.view?.didReceiveWeatherInfo(weatherInfo)
        }) { error in
            self.view?.stopLoading()
        }
    }
    
    func locationManagerDidFailWithError(error: NSError) {
        
    }    
}
