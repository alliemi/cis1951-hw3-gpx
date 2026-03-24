//
//  DiningHalls.swift
//  hw3
//
//  Created by Tim Liang on 3/24/26.
//

import CoreLocation

extension DiningHall {
    static let diningHalls: [DiningHall] = [
        DiningHall(
            name: "1920 Commons",
            location: CLLocation(
                latitude: CLLocationCoordinate2D.commons.latitude,
                longitude: CLLocationCoordinate2D.commons.longitude
            )
        ),
        DiningHall(
            name: "Accenture Café",
            location: CLLocation(
                latitude: CLLocationCoordinate2D.accenture.latitude,
                longitude: CLLocationCoordinate2D.accenture.longitude
            )
        ),
        DiningHall(
            name: "Falk Kosher Dining",
            location: CLLocation(
                latitude: CLLocationCoordinate2D.falk.latitude,
                longitude: CLLocationCoordinate2D.falk.longitude
            )
        ),
        DiningHall(
            name: "Hill House",
            location: CLLocation(
                latitude: CLLocationCoordinate2D.hill.latitude,
                longitude: CLLocationCoordinate2D.hill.longitude
            )
        ),
        DiningHall(
            name: "Houston Market",
            location: CLLocation(
                latitude: CLLocationCoordinate2D.houston.latitude,
                longitude: CLLocationCoordinate2D.houston.longitude
            )
        ),
        DiningHall(
            name: "Joe's Café",
            location: CLLocation(
                latitude: CLLocationCoordinate2D.joes.latitude,
                longitude: CLLocationCoordinate2D.joes.longitude
            )
        ),
        DiningHall(
            name: "Kings Court English House",
            location: CLLocation(
                latitude: CLLocationCoordinate2D.kceh.latitude,
                longitude: CLLocationCoordinate2D.kceh.longitude
            )
        ),
        DiningHall(
            name: "Lauder College House",
            location: CLLocation(
                latitude: CLLocationCoordinate2D.lauder.latitude,
                longitude: CLLocationCoordinate2D.lauder.longitude
            )
        ),
        DiningHall(
            name: "McClelland Express",
            location: CLLocation(
                latitude: CLLocationCoordinate2D.mcclelland.latitude,
                longitude: CLLocationCoordinate2D.mcclelland.longitude
            )
        ),
        DiningHall(
            name: "Pret A Manger",
            location: CLLocation(
                latitude: CLLocationCoordinate2D.pret.latitude,
                longitude: CLLocationCoordinate2D.pret.longitude
            )
        ),
        DiningHall(
            name: "Quaker Kitchen",
            location: CLLocation(
                latitude: CLLocationCoordinate2D.quaker.latitude,
                longitude: CLLocationCoordinate2D.quaker.longitude
            )
        )
    ]
}
