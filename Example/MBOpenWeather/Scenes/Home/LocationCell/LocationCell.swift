//
//  LocationCell.swift
//  MBOpenWeather_Example
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLocation(withCity cityName: String?, country: String?, latitude: Double?, longitude: Double?) {
        if let cityName = cityName, let country = country {
            locationNameLabel.text = "\(cityName) (\(country))"
        } else {
            locationNameLabel.text = cityName ?? "-"
        }
        
        if let latitude = latitude, let longitude = longitude {
            let location = CLLocation(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 50000, 60000)
            mapView.setRegion(region, animated: true)
        }
    }
}
