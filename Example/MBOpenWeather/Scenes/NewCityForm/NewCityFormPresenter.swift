//
//  NewCityFormPresenter.swift
//  MBOpenWeather_Example
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import UIKit

protocol NewCityFormPresenterProtocol: class {
    var view:NewCityFormViewProtocol? { get set }
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
    
}
