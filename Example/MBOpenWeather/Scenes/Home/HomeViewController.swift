//
//  HomeViewController.swift
//  MBOpenWeather_Example
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import UIKit
import MBOpenWeather

protocol HomeViewProtocol: class {
    func startLoading()
    func stopLoading()
    
    func didReceiveWeatherInfo(_ weatherInfo: MBWeatherModel)
}

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var emptyViewContainer: UIView!
    @IBOutlet weak var locationsTableView: UITableView!
    
    // MARK: - Public properties
    lazy var presenter:HomePresenterProtocol = HomePresenter(view: self)
      
    // MARK: - Private properties
    var savedLocations: [MBWeatherModel]?
    
    // MARK: - View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        
        locationsTableView.register(UINib(nibName: "LocationCell", bundle: nil), forCellReuseIdentifier: "LocationCell")

        savedLocations = presenter.loadSavedLocations()
        reloadTableView()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
  
    // MARK: - Display logic
    
    func initNavigationBar() {
        self.title = "Home"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(self.didSelectAddNewLocation(sender:)))
    }
  
    // MARK: - Actions
    
    @IBAction func didSelectLocationButton(_ sender: Any) {
        presenter.requestLocationUpdates()
    }
    
    @objc func didSelectAddNewLocation(sender: UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.appNavigator?.navigate(to: .newCityForm, withStyle: .present)
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    func reloadTableView() {
        if let savedLocations = savedLocations, savedLocations.count > 0 {
            locationsTableView.isHidden = false
            emptyViewContainer.isHidden = true
        } else {
            locationsTableView.isHidden = true
            emptyViewContainer.isHidden = false
        }
        
        locationsTableView.reloadData()
    }
}

extension HomeViewController:  HomeViewProtocol {
    
    func startLoading() {
        showLoading()
    }
    
    func stopLoading() {
        hideLoading()
    }
    
    func didReceiveWeatherInfo(_ weatherInfo: MBWeatherModel) {
        if (savedLocations == nil) {
            savedLocations = [MBWeatherModel]()
        }
        
        savedLocations!.append(weatherInfo)
        LocalStorageManager.saveWeatherInfo(weatherInfoArray: savedLocations!)
        
        reloadTableView()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let savedLocations = savedLocations {
            return savedLocations.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 222.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell

        let weatherInfo = savedLocations![indexPath.row]
        cell.setLocation(withCity: weatherInfo.name, country: weatherInfo.sys?.country, latitude: weatherInfo.coord?.lat, longitude: weatherInfo.coord?.lon)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.appNavigator?.navigate(to: .cityDetails, withStyle: .present)
    }
}
