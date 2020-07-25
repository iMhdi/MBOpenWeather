//
//  CityDetailsPresenter.swift
//  MBOpenWeather_Demo
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import UIKit
import MBOpenWeather

protocol CityDetailsPresenterProtocol: class {
    var view:CityDetailsViewProtocol? { get set }
    
    func constructDataSource(from weatherInfo: MBWeatherModel) -> [WeatherSingleInfoLine]
    func refreshWeatherInfo(weatherInfo: MBWeatherModel)
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
    
    func constructDataSource(from weatherInfo: MBWeatherModel) -> [WeatherSingleInfoLine] {
        var dataSource = [WeatherSingleInfoLine]()
        
        // MARK: - Measure Temperature
        if let temperatureC = weatherInfo.getTemperature(in: .celsius) {
            dataSource.append(WeatherSingleInfoLine(key: "Temperature", value: temperatureC))
        }
        
        // MARK: - Measure Conditions
        if let weatherDescription = weatherInfo.weatherDescription {
            dataSource.append(WeatherSingleInfoLine(key: "Conditions", value: weatherDescription))
        }
        
        // MARK: - Measure Cloud Coverage
        if let cloudCoverage = weatherInfo.cloudCoverage {
            dataSource.append(WeatherSingleInfoLine(key: "Cloud Coverage", value: cloudCoverage))
        }
        
        // MARK: - Measure Humidity
        if let humidity = weatherInfo.humidity {
            dataSource.append(WeatherSingleInfoLine(key: "Humidity", value: humidity))
        }
        
        // MARK: - Measure Pressure
        if let pressure = weatherInfo.pressure {
            dataSource.append(WeatherSingleInfoLine(key: "Pressure", value: pressure))
        }
        
        // MARK: - Measure Wind Direction
        if let directionDirection = weatherInfo.windDirection {
            dataSource.append(WeatherSingleInfoLine(key: "Wind Direction", value: directionDirection))
        }
        
        // MARK: - Measure Wind Speed
        if let windSpeedInKh = weatherInfo.getWindSpeed(in: .kmPerHour) {
            dataSource.append(WeatherSingleInfoLine(key: "Wind Speed", value: windSpeedInKh))
        }
        
        // MARK: - Measure Sunrise Time
        if let sunriseTime = weatherInfo.sunriseTime {
            dataSource.append(WeatherSingleInfoLine(key: "Sunrise Time", value: sunriseTime))
        }
        
        // MARK: - Measure Sunset Time
        if let sunsetTime = weatherInfo.sunsetTime {
            dataSource.append(WeatherSingleInfoLine(key: "Sunset Time", value: sunsetTime))
        }
        
        // MARK: - Measure Daylight Hours
        if let daylightHours = weatherInfo.daylightHours {
            dataSource.append(WeatherSingleInfoLine(key: "Daylight Hours", value: daylightHours))
        }
        
        return dataSource
    }
    
    func refreshWeatherInfo(weatherInfo: MBWeatherModel) {
        view?.startLoading()
        // For visual effect only (to see rotation animation)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            MBWeatherManager.shared.weatherInfo(forCityId: weatherInfo.id, withSuccess: { weatherInfo in
                self.view?.stopLoading()
                self.view?.didReceiveWeatherInfo(weatherInfo)
            }) { error in
                self.view?.stopLoading()
            }
        }
    }
}
