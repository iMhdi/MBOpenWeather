//
//  WeatherSingleInfoLine.swift
//  MBOpenWeather_Demo
//
//  Created by El Mahdi Boukhris on 25/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import Foundation

public class WeatherSingleInfoLine {
    var key: String
    var value: String
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
