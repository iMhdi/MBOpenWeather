//
//  LocationCell.swift
//  MBOpenWeather_Demo
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLocation(withCity cityName: String?, country: String?, temperature: String?, andIconName iconName: String?) {
        if let cityName = cityName, let country = country {
            locationNameLabel.text = "\(cityName) (\(country))"
        } else {
            locationNameLabel.text = cityName ?? "-"
        }
        
        if let iconName = iconName {
            weatherIcon.image = UIImage(named: iconName)
        }
        
        if let temperature = temperature {
            temperatureLabel.text = temperature
        } else {
            temperatureLabel.text = "- °C"
        }
    }
}
