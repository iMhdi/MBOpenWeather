//
//  LocalStorageManager.swift
//  MBOpenWeather_Example
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import MBOpenWeather

let USER_DEFAULTS_KEY_LOCATIONS = "USER_DEFAULTS_KEY_LOCATIONS"

class LocalStorageManager: NSObject {
    
    public static let shared = LocalStorageManager()

    var savedLocations = [MBWeatherModel]()
    
    private override init() {
        super.init()
    }
    
    func addWeatherInfo(weatherInfo: MBWeatherModel) {
        savedLocations.append(weatherInfo)
        
        saveWeatherInfos(weatherInfoArray: savedLocations)
    }
    
    func deleteWeatherInfo(atIndex index: Int) {
        savedLocations.remove(at: index)
        
        saveWeatherInfos(weatherInfoArray: savedLocations)
    }

    private func saveWeatherInfos(weatherInfoArray: [MBWeatherModel]) {
        let weatherInfoData = NSKeyedArchiver.archivedData(withRootObject: weatherInfoArray)
        UserDefaults.standard.set(weatherInfoData, forKey: USER_DEFAULTS_KEY_LOCATIONS)
    }
    
    func loadWeatherInfos() {
        let weatherInfoData = UserDefaults.standard.object(forKey: USER_DEFAULTS_KEY_LOCATIONS) as? Data

        if let weatherInfoData = weatherInfoData {
            let weatherInfoArray = NSKeyedUnarchiver.unarchiveObject(with: weatherInfoData) as? [MBWeatherModel]

            if let weatherInfoArray = weatherInfoArray {
                savedLocations = weatherInfoArray
                return
            }
        }
        
        savedLocations = [MBWeatherModel]()
    }
}
