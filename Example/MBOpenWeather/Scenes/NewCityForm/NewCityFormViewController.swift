//
//  NewCityFormViewController.swift
//  MBOpenWeather_Example
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import UIKit

protocol NewCityFormViewProtocol: class {
    func startLoading()
    func stopLoading()
}

class NewCityFormViewController: UIViewController {
    
    // MARK: - Public properties
    
    lazy var presenter:NewCityFormPresenterProtocol = NewCityFormPresenter(view: self)
      
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

extension NewCityFormViewController:  NewCityFormViewProtocol {
    
    func startLoading() {
        showLoading()
    }
    
    func stopLoading() {
        hideLoading()
    }
}
