//
//  Navigator.swift
//  MBOpenWeather_Demo
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import Foundation

protocol Navigator {
    associatedtype Destination
    associatedtype ViewControllerPresentationStyle
    
    func navigate(to destination: Destination, withStyle presentationStyle: ViewControllerPresentationStyle, andData dataDictionary:[String:Any]?)
}
