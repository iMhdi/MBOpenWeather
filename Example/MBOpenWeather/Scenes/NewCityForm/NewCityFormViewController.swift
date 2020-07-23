//
//  NewCityFormViewController.swift
//  MBOpenWeather_Example
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import UIKit
import MBOpenWeather

protocol NewCityFormViewProtocol: class {
    func startLoading()
    func stopLoading()
    
    func displayCityAddConfirmation(cityName: String, weatherInfo: MBWeatherModel)
    func displayCityAddError(error: String)
}

class NewCityFormViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cityNameTextfield: UITextField!
    @IBOutlet weak var addCityButton: UIButton!
    
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
        
    @IBAction func didSelectAddButton(_ sender: Any) {
        if let enteredCityName = cityNameTextfield.text {
            presenter.weatherInformation(withCity: enteredCityName)
        }
    }
    
    @IBAction func didEditTextfieldContent(_ sender: Any) {
        if let inputText = cityNameTextfield.text, inputText.count > 0 {
            addCityButton.isEnabled = true
        } else {
            addCityButton.isEnabled = false
        }
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
}

extension NewCityFormViewController:  NewCityFormViewProtocol {
    func displayCityAddError(error: String) {
        displayAlert(withMessage: "An error has occured :\n\(error)")
    }
    
    func displayCityAddConfirmation(cityName: String, weatherInfo: MBWeatherModel) {
        LocalStorageManager.shared.addWeatherInfo(weatherInfo: weatherInfo)

        NotificationCenter.default.post(name: Notification.Name(NOTIFICATION_CENTER_LIST_UPDATED), object: nil)

        displayAlert(withMessage: "\(cityName) was successfully added to your list.") { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func startLoading() {
        showLoading()
    }
    
    func stopLoading() {
        hideLoading()
    }
}
