//
//  MBWeatherModel.swift
//  MBOpenWeather
//
//  Created by El Mahdi Boukhris on 21/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import Foundation

@objc public enum TemperatureUnit: Int {
    case kelvin
    case celsius
    case fahrenheit
}

@objc public enum WindSpeedUnit: Int {
    case kmPerHour
    case milesPerHour
}

// MARK: - MBWeatherModel
@objc public class MBWeatherModel: NSObject, NSCoding, Codable {
    
    public let coord: Coord?
    public let weather: [Weather]?
    public let base: String?
    public let main: Main?
    public let visibility: Int?
    public let wind: Wind?
    public let clouds: Clouds?
    public let dt: Int?
    public let sys: Sys?
    public let timezone, id: Int?
    public let name: String?
    public let cod: Int?
    
    public init(coord: Coord?, weather: [Weather]?, base: String?, main: Main?, visibility: Int?, wind: Wind?, clouds: Clouds?, dt: Int?, sys: Sys?, timezone: Int?, id: Int?, name: String?, cod: Int?) {
        self.coord = coord
        self.weather = weather
        self.base = base
        self.main = main
        self.visibility = visibility
        self.wind = wind
        self.clouds = clouds
        self.dt = dt
        self.sys = sys
        self.timezone = timezone
        self.id = id
        self.name = name
        self.cod = cod
    }

    public required convenience init?(coder aCoder: NSCoder) {
        let coord       =   aCoder.decodeObject(forKey: "coord") as? Coord
        let weather     =   aCoder.decodeObject(forKey: "weather") as? [Weather]
        let base        =   aCoder.decodeObject(forKey: "base") as? String
        let main        =   aCoder.decodeObject(forKey: "main") as? Main
        let visibility  =   aCoder.decodeObject(forKey: "visibility") as? Int
        let wind        =   aCoder.decodeObject(forKey: "wind") as? Wind
        let clouds      =   aCoder.decodeObject(forKey: "clouds") as? Clouds
        let dt          =   aCoder.decodeObject(forKey: "dt") as? Int
        let sys         =   aCoder.decodeObject(forKey: "sys") as? Sys
        let timezone    =   aCoder.decodeObject(forKey: "timezone") as? Int
        let id          =   aCoder.decodeObject(forKey: "id") as? Int
        let name        =   aCoder.decodeObject(forKey: "name") as? String
        let cod         =   aCoder.decodeObject(forKey: "cod") as? Int

        self.init(coord: coord, weather: weather, base: base, main: main, visibility: visibility, wind: wind, clouds: clouds, dt: dt, sys: sys, timezone: timezone, id: id, name: name, cod: cod)
    }
    
    public func encode(with aCoder: NSCoder){
        aCoder.encode(coord, forKey: "coord")
        aCoder.encode(weather, forKey: "weather")
        aCoder.encode(base, forKey: "base")
        aCoder.encode(main, forKey: "main")
        aCoder.encode(visibility, forKey: "visibility")
        aCoder.encode(wind, forKey: "wind")
        aCoder.encode(clouds, forKey: "clouds")
        aCoder.encode(dt, forKey: "dt")
        aCoder.encode(sys, forKey: "sys")
        aCoder.encode(timezone, forKey: "timezone")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(cod, forKey: "cod")
    }
    
    // MARK: - easy access properties
    @objc public var weatherDescription: String? {
        if let weatherDescription = self.weather?.first?.weatherDescription {
            return weatherDescription
        }
        return nil
    }
    
    @objc public var humidity: String? {
        if let humidity = self.main?.humidity {
            return "\(humidity)%"
        }
        return nil
    }

    @objc public var pressure: String? {
        if let pressure = self.main?.pressure {
            return "\(Int(pressure))hPa"
        }
        return nil
    }

    @objc public var windDirection: String? {
        if let directionInDegrees = self.wind?.deg {
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

            return returnValue;
        }
        return nil
    }

    @objc public var cloudCoverage: String? {
        if let cloudCoverage = self.clouds?.all {
            return "\(cloudCoverage)%";
        }
        return nil
    }
    
    @objc public var sunriseTime: String? {
        if let sunrise = self.sys?.sunrise, let timezone = self.timezone {
            let sunriseUTCTimeStamp = Date(timeIntervalSince1970: TimeInterval(sunrise))
            
            let localFormatter = DateFormatter()
            localFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
            localFormatter.dateFormat = "HH:mm"
            
            return localFormatter.string(from: sunriseUTCTimeStamp)
        }
        return nil
    }
    
    @objc public var sunsetTime: String? {
        if let sunset = self.sys?.sunset, let timezone = self.timezone {
            let sunsetUTCTimeStamp = Date(timeIntervalSince1970: TimeInterval(sunset))
            
            let localFormatter = DateFormatter()
            localFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
            localFormatter.dateFormat = "HH:mm"
            
            return localFormatter.string(from: sunsetUTCTimeStamp)
        }
        return nil
    }
    
    @objc public var daylightHours: String? {
        if let sunriseTime = self.sunriseTime, let sunsetTime = self.sunsetTime {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"

            if let sunrise = formatter.date(from: sunriseTime), let sunset = formatter.date(from: sunsetTime) {
                let interval    = sunset.timeIntervalSince(sunrise)
                let hours       = interval / 3600
                let minutes     = (interval - (hours * 3600)) / 60
                
                if minutes == 0 {
                    return "\(Int(hours))"
                } else if minutes < 10 {
                    return "\(Int(hours)):0\(Int(minutes))"
                } else {
                    return "\(Int(hours)):\(Int(minutes))"
                }
            }
        }
        return nil
    }

    // MARK: - easy access functions
    @objc public func getTemperature(in unit: TemperatureUnit = .kelvin) -> String? {
        if let temperatureK = self.main?.temp {
            switch unit {
            case .kelvin:
                return "\(temperatureK)°K"
            case .celsius:
                let temperatureC = Int(temperatureK - 273.15)
                return "\(temperatureC)°C"
            case .fahrenheit:
                let temperatureF = Int((temperatureK - 273.15) * 1.8000 + 32.00)
                return "\(temperatureF)°F"
            }
        }
        return nil
    }
    
    @objc public func getWindSpeed(in unit: WindSpeedUnit = .kmPerHour) -> String? {
        if let windSpeedInMS = self.wind?.speed {
            switch unit {
            case .kmPerHour:
                let windSpeedInKh: Int = Int(windSpeedInMS * 3.6)
                return "\(windSpeedInKh)Km/h"
            case .milesPerHour:
                let windSpeedInMH: Int = Int(windSpeedInMS * 2.2369)
                return "(\(windSpeedInMH)M/h)"
            }
        }
        return nil
    }
    
    static func ==(lhs: MBWeatherModel, rhs: MBWeatherModel) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Clouds
public class Clouds: NSObject, NSCoding, Codable {
    public let all: Int?
    
    public init(all: Int?) {
        self.all = all
    }
    
    public required convenience init?(coder aCoder: NSCoder) {
        let all       =   aCoder.decodeObject(forKey: "all") as? Int
        
        self.init(all: all)
    }

    public func encode(with aCoder: NSCoder){
        aCoder.encode(all, forKey: "all")
    }
}

// MARK: - Coord
public class Coord: NSObject, NSCoding, Codable {
    public let lon, lat: Double?
    
    public init(lon: Double?, lat: Double?) {
        self.lon = lon
        self.lat = lat
    }
    
    public required convenience init?(coder aCoder: NSCoder) {
        let lon       =   aCoder.decodeObject(forKey: "lon") as? Double
        let lat       =   aCoder.decodeObject(forKey: "lat") as? Double
        
        self.init(lon: lon, lat: lat)
    }

    public func encode(with aCoder: NSCoder){
        aCoder.encode(lon, forKey: "lon")
        aCoder.encode(lat, forKey: "lat")
    }
}

// MARK: - Main
public class Main: NSObject, NSCoding, Codable {
    public let temp, feelsLike, tempMin, tempMax: Double?
    public let pressure, humidity: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
    
    public init(temp: Double?, feelsLike: Double?, tempMin: Double?, tempMax: Double?, pressure: Double?, humidity: Double?) {
        self.temp = temp
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
    }
    
    public required convenience init?(coder aCoder: NSCoder) {
        let temp       =   aCoder.decodeObject(forKey: "temp") as? Double
        let feelsLike  =   aCoder.decodeObject(forKey: "feelsLike") as? Double
        let tempMin    =   aCoder.decodeObject(forKey: "tempMin") as? Double
        let tempMax    =   aCoder.decodeObject(forKey: "tempMax") as? Double
        let pressure   =   aCoder.decodeObject(forKey: "pressure") as? Double
        let humidity   =   aCoder.decodeObject(forKey: "humidity") as? Double
        
        self.init(temp: temp, feelsLike: feelsLike, tempMin: tempMin, tempMax: tempMax, pressure: pressure, humidity: humidity)
    }
    
    public func encode(with aCoder: NSCoder){
        aCoder.encode(temp, forKey: "temp")
        aCoder.encode(feelsLike, forKey: "feelsLike")
        aCoder.encode(tempMin, forKey: "tempMin")
        aCoder.encode(tempMax, forKey: "tempMax")
        aCoder.encode(pressure, forKey: "pressure")
        aCoder.encode(humidity, forKey: "humidity")
    }
}

// MARK: - Sys
public class Sys: NSObject, NSCoding, Codable {
    public let type, id: Int?
    public let message: Double?
    public let country: String?
    public let sunrise, sunset: Int?
    
    public init(type: Int?, id: Int?, message: Double?, country: String?, sunrise: Int?, sunset: Int?) {
        self.type = type
        self.id = id
        self.message = message
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
    }
    
    public required convenience init?(coder aCoder: NSCoder) {
        let type        =   aCoder.decodeObject(forKey: "type") as? Int
        let id          =   aCoder.decodeObject(forKey: "id") as? Int
        let message     =   aCoder.decodeObject(forKey: "message") as? Double
        let country     =   aCoder.decodeObject(forKey: "country") as? String
        let sunrise     =   aCoder.decodeObject(forKey: "sunrise") as? Int
        let sunset      =   aCoder.decodeObject(forKey: "sunset") as? Int
        
        self.init(type: type, id: id, message: message, country: country, sunrise: sunrise, sunset: sunset)
    }
    
    public func encode(with aCoder: NSCoder){
        aCoder.encode(type, forKey: "type")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(message, forKey: "message")
        aCoder.encode(country, forKey: "country")
        aCoder.encode(sunrise, forKey: "sunrise")
        aCoder.encode(sunset, forKey: "sunset")
    }
}

// MARK: - Weather
public class Weather: NSObject, NSCoding, Codable {
    public let id: Int?
    public let main, weatherDescription, icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    
    public init(id: Int?, main: String?, weatherDescription: String?, icon: String?) {
        self.id = id
        self.main = main
        self.weatherDescription = weatherDescription
        self.icon = icon
    }
    
    public required convenience init?(coder aCoder: NSCoder) {
        let id                      =   aCoder.decodeObject(forKey: "id") as? Int
        let main                    =   aCoder.decodeObject(forKey: "main") as? String
        let weatherDescription      =   aCoder.decodeObject(forKey: "weatherDescription") as? String
        let icon                    =   aCoder.decodeObject(forKey: "icon") as? String
        
        self.init(id: id, main: main, weatherDescription: weatherDescription, icon: icon)
    }
    
    public func encode(with aCoder: NSCoder){
        aCoder.encode(id, forKey: "id")
        aCoder.encode(main, forKey: "main")
        aCoder.encode(weatherDescription, forKey: "weatherDescription")
        aCoder.encode(icon, forKey: "icon")
    }
}

// MARK: - Wind
public class Wind: NSObject, NSCoding, Codable {
    public let speed: Double?
    public let deg: Int?
    
    public init(speed: Double?, deg: Int?) {
        self.speed = speed
        self.deg = deg
    }
    
    public required convenience init?(coder aCoder: NSCoder) {
        let speed     =   aCoder.decodeObject(forKey: "speed") as? Double
        let deg       =   aCoder.decodeObject(forKey: "deg") as? Int
        
        self.init(speed: speed, deg: deg)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(speed, forKey: "speed")
        aCoder.encode(deg, forKey: "deg")
    }
}
