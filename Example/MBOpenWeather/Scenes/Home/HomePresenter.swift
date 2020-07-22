//
//  HomePresenter.swift
//  MBOpenWeather_Example
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import UIKit

protocol HomePresenterProtocol: class {
    var view:HomeViewProtocol? { get set }
}

class HomePresenter {
  
    // MARK: - Public variables
    weak var view:HomeViewProtocol?
  
    // MARK: - Private variables
  
    // MARK: - Initialization
    init(view:HomeViewProtocol) {
        self.view = view
    }
}

extension HomePresenter: HomePresenterProtocol {
    
}
