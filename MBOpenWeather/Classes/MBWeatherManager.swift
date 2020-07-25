//
//  MBWeatherManager.swift
//  MBOpenWeather
//
//  Created by El Mahdi Boukhris on 21/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import Foundation

fileprivate let BASE_URL = "http://api.openweathermap.org/data/2.5/"

fileprivate let ENDPOINT_WEATHER = BASE_URL + "weather"

public class MBWeatherManager {
    

    // MARK: - Properties

    public static let shared = MBWeatherManager()

    // MARK: -

    var apiKey: String? = nil

    // MARK: - Initialization

    private init() { }

    public func setAPIKey(_ apiKey: String?) {
        self.apiKey = apiKey
    }
    
    public func weatherInfo(forCityId cityId:Int?, withSuccess success:@escaping (MBWeatherModel) -> Void, andFailure failure:@escaping (NSError) -> Void) {
        
        guard let apiKey = apiKey else {
            return failure(NSError(domain:"MISSING_API_KEY", code:-3, userInfo:nil))
        }
        
        guard let cityId = cityId else {
            return failure(NSError(domain:"MISSING_CITY_IDENTIFIER", code:-4, userInfo:nil))
        }
        
        MBRequestWrapper.requestAPI(withURL: ENDPOINT_WEATHER, method: "GET", andParameters: ["appid": apiKey, "id": "\(cityId)"], success: success, failure: failure)
    }
    
    public func weatherInfo(forCityName cityName:String, withSuccess success:@escaping (MBWeatherModel) -> Void, andFailure failure:@escaping (NSError) -> Void) {
        
        guard let apiKey = apiKey else {
            return failure(NSError(domain:"MISSING_API_KEY", code:-3, userInfo:nil))
        }
        
        MBRequestWrapper.requestAPI(withURL: ENDPOINT_WEATHER, method: "GET", andParameters: ["appid": apiKey, "q": cityName], success: success, failure: failure)
    }
    
    public func weatherInfo(forLatitude latitude:Double, longitude: Double, withSuccess success:@escaping (MBWeatherModel) -> Void, andFailure failure:@escaping (NSError) -> Void) {
        
        guard let apiKey = apiKey else {
            return failure(NSError(domain:"MISSING_API_KEY", code:-3, userInfo:nil))
        }
        
        MBRequestWrapper.requestAPI(withURL: ENDPOINT_WEATHER, method: "GET", andParameters: ["appid": apiKey, "lat": "\(latitude)", "lon": "\(longitude)"], success: success, failure: failure)
    }
}
