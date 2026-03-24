//
//  DiningHallViewModel.swift
//  hw3
//
//  Created by Tim Liang on 3/24/26.
//

import SwiftUI
import CoreLocation

@Observable class DiningHallViewModel {
    let diningHalls: [DiningHall] = DiningHall.diningHalls
    var currentDiningHall: DiningHall? = nil
}
