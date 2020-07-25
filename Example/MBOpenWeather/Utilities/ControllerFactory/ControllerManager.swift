//
//  ControllerManager.swift
//  MBOpenWeather_Demo
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import UIKit
import MBOpenWeather

class ControllerFactory {
    
    static func newInstance(for destination: Destination, withData dataDictionary:[String:Any]? = nil) -> UIViewController {
        switch destination {
        case .home:
            return UIViewController.newInstance(of: HomeViewController())
        case .cityDetails:
            let detailsController = UIViewController.newInstance(of: CityDetailsViewController())
            detailsController.currentLocation = (dataDictionary!["currentLocation"] as! MBWeatherModel)

            let navController = AppNavigator(rootViewController: detailsController)
            return navController
        case .newCityForm:
            let formController = UIViewController.newInstance(of: NewCityFormViewController())

            let navController = AppNavigator(rootViewController: formController)
            return navController
        }
    }
}
