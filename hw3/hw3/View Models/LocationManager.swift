//
//  LocationManager.swift
//  hw3
//
//  Created by Allison Mi on 3/24/26.
//

import Foundation
import CoreLocation

@Observable class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    var userLocation: CLLocation?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var locationError: String?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestPermission() {
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }

    func requestLocation() {
        locationError = nil
        manager.requestLocation()
    }

    func distanceToHall(_ hall: DiningHall) -> CLLocationDistance? {
        userLocation?.distance(from: hall.location)
    }

    func isWithinRange(of hall: DiningHall, meters: Double = 50) -> Bool {
        guard let distance = distanceToHall(hall) else { return false }
        return distance <= meters
    }


    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        MainActor.assumeIsolated {
            userLocation = locations.last
        }
    }

    nonisolated func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        MainActor.assumeIsolated {
            locationError = error.localizedDescription
        }
    }

    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        MainActor.assumeIsolated {
            authorizationStatus = manager.authorizationStatus
            if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
                self.requestLocation()
            }
        }
    }
}
