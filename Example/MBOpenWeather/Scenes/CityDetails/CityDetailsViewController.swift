//
//  CityDetailsViewController.swift
//  MBOpenWeather_Demo
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import UIKit
import MapKit
import MBOpenWeather

protocol CityDetailsViewProtocol: class {
    func startLoading()
    func stopLoading()
    
    func didReceiveWeatherInfo(_ weatherInfo: MBWeatherModel)
}

struct TableViewDataSource {
    var key: String
    var value: String
}

class CityDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var detailsTableView: UITableView!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    // MARK: - Public properties
    lazy var presenter:CityDetailsPresenterProtocol = CityDetailsPresenter(view: self)
      
    // MARK: - Private properties
    var currentLocation: MBWeatherModel?
    var detailsArray = [WeatherSingleInfoLine]()

    // MARK: - View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTableView.register(UINib(nibName: "DetailsCell", bundle: nil), forCellReuseIdentifier: "DetailsCell")
        
        initNavigationBar()
        populateView()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
  
    // MARK: - Display logic
    
    func initNavigationBar() {
        self.title = "City information"
        
        let backButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.didCloseButton(sender:)))

        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func initMapViewSection() {
        if let cityName = currentLocation?.name, let country = currentLocation?.sys?.country {
            locationNameLabel.text = "\(cityName) (\(country))"
        } else {
            locationNameLabel.text = currentLocation?.name ?? "-"
        }
        
        if let iconName = currentLocation?.weather?.first?.icon {
            weatherIcon.image = UIImage(named: iconName)
        }
        
        if let latitude = currentLocation?.coord?.lat, let longitude = currentLocation?.coord?.lon {
            let location = CLLocationCoordinate2DMake(latitude, longitude)
            
            let marker = MKPointAnnotation()
            marker.coordinate = location
            marker.title = locationNameLabel.text

            mapView.addAnnotation(marker)
            mapView.setCenter(location, animated: true)
        }
    }
    
    func populateView() {
        initMapViewSection()
        
        if let currentLocation = currentLocation {
            detailsArray = presenter.constructDataSource(from: currentLocation)
        }

        detailsTableView.reloadData()
    }

    // MARK: - Actions
    
    @IBAction func didSelectRefreshButton(_ sender: Any) {
        presenter.refreshWeatherInfo(weatherInfo: currentLocation!)
    }
    
    @objc func didCloseButton(sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
}

extension CityDetailsViewController:  CityDetailsViewProtocol {
    
    func startLoading() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = 1
        rotateAnimation.repeatCount = Float.infinity
        refreshButton.layer.add(rotateAnimation, forKey: nil)
    }
    
    func stopLoading() {
        refreshButton.layer.removeAllAnimations()
    }
    
    func didReceiveWeatherInfo(_ weatherInfo: MBWeatherModel) {
        LocalStorageManager.shared.deleteWeatherInfo(weatherInfo: currentLocation!)
        
        currentLocation = weatherInfo
        LocalStorageManager.shared.addWeatherInfo(weatherInfo: weatherInfo)
        
        populateView()
    }
}

extension CityDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell

        let currentItem         = detailsArray[indexPath.row]
        
        cell.keyLabel.text      = currentItem.key
        cell.valueLabel.text    = currentItem.value
        cell.selectionStyle     = .none
        
        return cell
    }
}
