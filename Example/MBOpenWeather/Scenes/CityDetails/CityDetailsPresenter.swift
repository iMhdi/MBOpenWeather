//
//  CityDetailsPresenter.swift
//  MBOpenWeather_Example
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import UIKit

protocol CityDetailsPresenterProtocol: class {
    var view:CityDetailsViewProtocol? { get set }
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
    
}
