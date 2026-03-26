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
    private(set) var collectedIDs: Set<UUID> = []

    func isCollected(_ diningHall: DiningHall) -> Bool {
        collectedIDs.contains(diningHall.id)
    }

    func collect(_ diningHall: DiningHall) {
        collectedIDs.insert(diningHall.id)
    }
}
