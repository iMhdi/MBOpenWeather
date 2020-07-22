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

class LocalStorageManager {
    
    static func saveWeatherInfo(weatherInfoArray: [MBWeatherModel]) {
        let weatherInfoData = NSKeyedArchiver.archivedData(withRootObject: weatherInfoArray)
        UserDefaults.standard.set(weatherInfoData, forKey: USER_DEFAULTS_KEY_LOCATIONS)
    }
    
    static func loadWeatherInfo() -> [MBWeatherModel]? {
        let weatherInfoData = UserDefaults.standard.object(forKey: USER_DEFAULTS_KEY_LOCATIONS) as? Data

        if let weatherInfoData = weatherInfoData {
            let weatherInfoArray = NSKeyedUnarchiver.unarchiveObject(with: weatherInfoData) as? [MBWeatherModel]

            return weatherInfoArray
        }
        
        return nil
    }
}
