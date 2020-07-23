//
//  ControllerManager.swift
//  MBOpenWeather_Example
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import MBOpenWeather

class ControllerFactory {
    
    static func newInstance(for destination: Destination, withData dataDictionary:[String:Any]? = nil) -> UIViewController {
        switch destination {
        case .home:
            return UIViewController.newInstance(of: HomeViewController())
        case .cityDetails:
            return UIViewController.newInstance(of: CityDetailsViewController())
        case .newCityForm:
            return UIViewController.newInstance(of: NewCityFormViewController())
        }
    }
}
