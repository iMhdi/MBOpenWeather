//
//  NewCityFormPresenter.swift
//  MBOpenWeather_Demo
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import UIKit
import MBOpenWeather

protocol NewCityFormPresenterProtocol: class {
    var view:NewCityFormViewProtocol? { get set }
    
    func weatherInformation(withCity cityName: String)
}

class NewCityFormPresenter {
  
    // MARK: - Public variables
    weak var view:NewCityFormViewProtocol?
  
    // MARK: - Private variables
  
    // MARK: - Initialization
    init(view:NewCityFormViewProtocol) {
        self.view = view
    }
}

extension NewCityFormPresenter: NewCityFormPresenterProtocol {
    func weatherInformation(withCity cityName: String) {
        view?.startLoading()
        MBWeatherManager.shared.weatherInfo(forCityName: cityName, withSuccess: { weatherInfo in
            self.view?.stopLoading()
            self.view?.displayCityAddConfirmation(cityName: cityName, weatherInfo: weatherInfo)
        }) { error in
            self.view?.stopLoading()
            self.view?.displayCityAddError(error: error.localizedDescription)
        }
    }
}
