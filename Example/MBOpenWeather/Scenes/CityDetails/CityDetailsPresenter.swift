//
//  CityDetailsPresenter.swift
//  MBOpenWeather_Example
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import UIKit
import MBOpenWeather

protocol CityDetailsPresenterProtocol: class {
    var view:CityDetailsViewProtocol? { get set }
    
    func constructDataSource(from weatherInfo: MBWeatherModel) -> [String: String]
}

class CityDetailsPresenter {
  
    // MARK: - Public variables
    weak var view:CityDetailsViewProtocol?
  
    // MARK: - Private variables
  
    // MARK: - Initialization
    init(view:CityDetailsViewProtocol) {
        self.view = view
    }
}

extension CityDetailsPresenter: CityDetailsPresenterProtocol {
    
    //TODO: expose these measurements directly from the data model
    func constructDataSource(from weatherInfo: MBWeatherModel) -> [String : String] {
        var dataSource = [String : String]()
        
        // MARK: - Measure Conditions
        if let weatherDescription = weatherInfo.weather?.first?.weatherDescription {
            dataSource["Conditions"] = "\(weatherDescription)"
        }
        
        // MARK: - Measure Temperature
        if let temperatureK = weatherInfo.main?.temp {
            let temperatureC = Int(temperatureK - 273.15)
            let temperatureF = Int((temperatureK - 273.15) * 1.8000 + 32.00)
            dataSource["Temperature"] = "\(temperatureC)°C (\(temperatureF)°F)";
        }
        
        // MARK: - Measure Humidity
        if let humidity = weatherInfo.main?.humidity {
            dataSource["Humidity"] = "\(humidity)%"
        }
        
        // MARK: - Measure Pressure
        if let pressure = weatherInfo.main?.pressure {
            dataSource["Pressure"] = "\(Int(pressure))hPa"
        }
        
        // MARK: - Measure Wind Speed
        if let windSpeedInMS = weatherInfo.wind?.speed {
            let windSpeedInKh: Int = Int(windSpeedInMS * 3.6)
            let windSpeedInMH: Int = Int(windSpeedInMS * 2.2369)
            dataSource["Wind Speed"] = "\(windSpeedInKh)Km/h (\(windSpeedInMH)M/h)"
        }
        
        // MARK: - Measure Wind Direction
        if let directionInDegrees = weatherInfo.wind?.deg {
            var returnValue = "N/A"
            if ((directionInDegrees >= 339) || (directionInDegrees <= 22)) {
                returnValue = "N";
            } else if ((directionInDegrees > 23) && (directionInDegrees <= 68)) {
                returnValue = "NE";
            } else if ((directionInDegrees > 69) && (directionInDegrees <= 113)) {
                returnValue = "E";
            } else if ((directionInDegrees > 114) && (directionInDegrees <= 158)) {
                returnValue = "SE";
            } else if ((directionInDegrees > 159) && (directionInDegrees <= 203)) {
                returnValue = "S";
            } else if ((directionInDegrees > 204) && (directionInDegrees <= 248)) {
                returnValue = "SW";
            } else if ((directionInDegrees > 249) && (directionInDegrees <= 293)) {
                returnValue = "W";
            } else if ((directionInDegrees > 294) && (directionInDegrees <= 338)) {
                returnValue = "NW";
            }

            dataSource["Wind Direction"] = returnValue;
        }
        
        // MARK: - Measure Cloud Coverage
        if let cloudCoverage = weatherInfo.clouds?.all {
            dataSource["Cloud Coverage"] = "\(cloudCoverage)%";
        }
        
        return dataSource
    }
}
