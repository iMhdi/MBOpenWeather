//
//  CityDetailsViewController.swift
//  MBOpenWeather_Example
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
}

class CityDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var detailsTableView: UITableView!
    
    // MARK: - Public properties
    lazy var presenter:CityDetailsPresenterProtocol = CityDetailsPresenter(view: self)
      
    // MARK: - Private properties
    var currentLocation: MBWeatherModel?
    var detailsDictionnary = [String: String]()

    // MARK: - View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMapViewSection()
        
        if let currentLocation = currentLocation {
            detailsDictionnary = presenter.constructDataSource(from: currentLocation)
        }

        detailsTableView.register(UINib(nibName: "DetailsCell", bundle: nil), forCellReuseIdentifier: "DetailsCell")
        detailsTableView.reloadData()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
  
    // MARK: - Display logic
    
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
            let region = MKCoordinateRegionMakeWithDistance(location, 3000, 3000)
            mapView.setRegion(region, animated: true)
        }
    }

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

extension CityDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsDictionnary.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell

        let keys: [String]      = detailsDictionnary.map({ $0.key })
        let currentKey          = keys[indexPath.row]
        
        cell.keyLabel.text      = currentKey
        cell.valueLabel.text    = detailsDictionnary[currentKey]
        cell.selectionStyle     = .none
        
        return cell
    }
}
