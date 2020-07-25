# MBOpenWeather

[![Version](https://img.shields.io/cocoapods/v/MBOpenWeather.svg?style=flat)](https://cocoapods.org/pods/MBOpenWeather)
[![License](https://img.shields.io/cocoapods/l/MBOpenWeather.svg?style=flat)](https://cocoapods.org/pods/MBOpenWeather)
[![Platform](https://img.shields.io/cocoapods/p/MBOpenWeather.svg?style=flat)](https://cocoapods.org/pods/MBOpenWeather)

**MBOpenWeather** is a simple [OpenWeather](https://openweathermap.org/current) API Wrapper that allows for :

- [x] Making seemless API Calls
- [x] Retrieving Weather information about a specified location (By ID, Coordinates or Name)
- [x] Returning simplified, human-readable values

## Demo

<p align="left">
<img width="350px" src="MBOpenWeather-demo.gif">
</p>

## Requirements

- Swift 4
- iOS 11.0+


## Installation

MBOpenWeather is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MBOpenWeather'
```
## Usage

### Init

Make sure you provide the framework with the API Key it needs to function

```swift
MBWeatherManager.shared.setAPIKey("")
```
### Available API Calls
**MBOpenWeather** allow for Retrieving Weather information about a specified location, locations can be specified using 1 of 3 methods :

#### 1 - By ID
```swift
public func weatherInfo(forCityId cityId:Int?, withSuccess success:@escaping (MBWeatherModel) -> Void, andFailure failure:@escaping (NSError) -> Void) 
```

#### 2 - By Coordinates (latitude/longitude)
```swift
public func weatherInfo(forLatitude latitude:Double, longitude: Double, withSuccess success:@escaping (MBWeatherModel) -> Void, andFailure failure:@escaping (NSError) -> Void)
```

#### 3 - By City Name
```swift
public func weatherInfo(forCityName cityName:String, withSuccess success:@escaping (MBWeatherModel) -> Void, andFailure failure:@escaping (NSError) -> Void)
```
### Return values
#### Success
In case **MBOpenWeather** is able to retrieve the requested information, each of the 3 functions mentionned earlier will return an **MBWeatherModel** object that contains all relevant weather information about the selected location.
Here's the structure of the object returned (as defined by openweathermap.org) :

* **coord**
	* **coord.lon** City geo location, longitude
	* **coord.lat** City geo location, latitude
* **weather** (more info Weather condition codes)
	* **weather.id** Weather condition id
	* **weather.main** Group of weather parameters (Rain, Snow, Extreme etc.)
	* **weather.description** Weather condition within the group. You can get the output in your language. Learn more
	* **weather.icon** Weather icon id
* **base** Internal parameter
* **main**
	* **main.temp** Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
	* **main.feels_like** Temperature. This temperature parameter accounts for the human perception of weather. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
	* **main.pressure** Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
	* **main.humidity** Humidity, %
	* **main.temp_min** Minimum temperature at the moment. This is minimal currently observed temperature (within large megalopolises and urban areas). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
	* **main.temp_max** Maximum temperature at the moment. This is maximal currently observed temperature (within large megalopolises and urban areas). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
	* **main.sea_level** Atmospheric pressure on the sea level, hPa
	* **main.grnd_level** Atmospheric pressure on the ground level, hPa
* **wind**
	* **wind.speed** Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
	* **wind.deg** Wind direction, degrees (meteorological)
	* **wind.gust** Wind gust. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour
* **clouds**
	* **clouds.all** Cloudiness, %
* **rain**
	* **rain.1h** Rain volume for the last 1 hour, mm
	* **rain.3h** Rain volume for the last 3 hours, mm
* **snow**
	* **snow.1h** Snow volume for the last 1 hour, mm
	* **snow.3h** Snow volume for the last 3 hours, mm
* **dt** Time of data calculation, unix, UTC
* **sys**
	* **sys.type** Internal parameter
	* **sys.id** Internal parameter
	* **sys.message** Internal parameter
	* **sys.country** Country code (GB, JP etc.)
	* **sys.sunrise** Sunrise time, unix, UTC
	* **sys.sunset** Sunset time, unix, UTC
* **timezone** Shift in seconds from UTC
* **id** City ID
* **name** City name
* **cod** Internal parameter

The model also exposes some values in human-readable format :

```swift
@objc public var weatherDescription: String? // ex : Overcast clouds
```
```swift
@objc public var humidity: String? // ex : 68%
```
```swift
@objc public var pressure: String? // ex : 1008hPA
```
```swift
@objc public var windDirection: String? // ex : SW
```
```swift
@objc public var cloudCoverage: String? // ex : 90%
```
```swift
@objc public var sunriseTime: String? // ex : 05:13
```
```swift
@objc public var sunsetTime: String? // ex : 20:58
```
```swift
@objc public var daylightHours: String? // ex : 15
```
```swift
@objc public func getTemperature(in unit: TemperatureUnit = .kelvin) -> String? // ex : 21°C
```
```swift
@objc public func getWindSpeed(in unit: WindSpeedUnit = .kmPerHour) -> String? // ex : 21Km/h
```

#### Failure
In case a request fails, **MBOpenWeather** will return an error object, this is the list of known error code :

| Code | Domain                  |
|------|-------------------------|
| -1   | INVALID_URL             |
| -2   | UNSUPPORTED_METHOD      |
| -3   | MISSING_API_KEY         |
| -4   | MISSING_CITY_IDENTIFIER |
| -5   | INVALID_RESPONSE        |
| -6   | INVALID_RESPONSE_CODE   |

## Author

m.boukhris@gmail.com

## License

MBOpenWeather is available under the MIT license. See the LICENSE file for more info.
