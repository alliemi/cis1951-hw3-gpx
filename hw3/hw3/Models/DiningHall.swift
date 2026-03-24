//
//  DiningHall.swift
//  hw3
//
//  Created by Tim Liang on 3/24/26.
//

import SwiftUI
import CoreLocation

struct DiningHall: Identifiable {
    var id: UUID = UUID()
    var name: String
    var location: CLLocation
    var isCollected: Bool = false
}
