//
//  DiningHall.swift
//  hw3
//
//  Created by Tim Liang on 3/24/26.
//

import Foundation
import CoreLocation

struct DiningHall: Identifiable {
    let id: UUID = UUID()
    let name: String
    let location: CLLocation
}
