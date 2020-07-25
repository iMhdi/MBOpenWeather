//
//  Array+Extension.swift
//  MBOpenWeather_Demo
//
//  Created by El Mahdi Boukhris on 25/07/2020.
//  Copyright © 2020 El Mahdi Boukhris. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    mutating func remove(element: Element) {
        if let i = self.firstIndex(of: element) {
            self.remove(at: i)
        }
    }
}
