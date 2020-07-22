//
//  CityDetailsViewController.swift
//  MBOpenWeather_Example
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import UIKit

protocol CityDetailsViewProtocol: class {
    func startLoading()
    func stopLoading()
}

class CityDetailsViewController: UIViewController {
    
    // MARK: - Public properties
    
    lazy var presenter:CityDetailsPresenterProtocol = CityDetailsPresenter(view: self)
      
    // MARK: - Private properties
  
    // MARK: - View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
  
    // MARK: - Display logic
  
    // MARK: - Actions
        
    // MARK: - Overrides
    
    // MARK: - Private functions
}

extension CityDetailsViewController:  CityDetailsViewProtocol {
    
    func startLoading() {
        showLoading()
    }
    
    func stopLoading() {
        hideLoading()
    }
}
