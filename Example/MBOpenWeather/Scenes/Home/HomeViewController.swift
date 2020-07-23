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
    
    // MARK: - View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        
        locationsTableView.register(UINib(nibName: "LocationCell", bundle: nil), forCellReuseIdentifier: "LocationCell")

        reloadTableView()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didUpdateLocationsList), name: NSNotification.Name(rawValue: NOTIFICATION_CENTER_LIST_UPDATED), object: nil)
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
        navController.navigate(to: .newCityForm, withStyle: .present)
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    func reloadTableView() {
        if LocalStorageManager.shared.savedLocations.count > 0 {
            locationsTableView.isHidden = false
            emptyViewContainer.isHidden = true
        } else {
            locationsTableView.isHidden = true
            emptyViewContainer.isHidden = false
        }
        
        locationsTableView.reloadData()
    }
    
    @objc private func didUpdateLocationsList(notification: NSNotification){
        reloadTableView()
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
        LocalStorageManager.shared.addWeatherInfo(weatherInfo: weatherInfo)
        
        reloadTableView()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalStorageManager.shared.savedLocations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 222.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell

        let weatherInfo = LocalStorageManager.shared.savedLocations[indexPath.row]
        cell.setLocation(withCity: weatherInfo.name, country: weatherInfo.sys?.country, latitude: weatherInfo.coord?.lat, longitude: weatherInfo.coord?.lon)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navController.navigate(to: .cityDetails, withStyle: .present)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            LocalStorageManager.shared.deleteWeatherInfo(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.reloadTableView()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }    
}
