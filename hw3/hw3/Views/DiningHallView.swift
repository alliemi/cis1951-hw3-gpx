//
//  DiningHallView.swift
//  hw3
//
//  Created by Tim Liang on 3/24/26.
//

import SwiftUI

struct DiningHallView: View {
    @Environment(DiningHallViewModel.self) var vm
    let diningHall: DiningHall

    @State private var locationManager = LocationManager()
    @State private var shakeDetector = ShakeDetector()
    @State private var justCollected = false

    var isNearby: Bool {
        locationManager.isWithinRange(of: diningHall)
    }

    var body: some View {
        VStack(spacing: 20) {
            if vm.isCollected(diningHall) {
                collectedView
            } else if locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted {
                permissionDeniedView
            } else if let error = locationManager.locationError {
                locationErrorView(error)
            } else if locationManager.userLocation == nil {
                ProgressView("Checking your location...")
            } else if !isNearby {
                tooFarView
            } else {
                nearbyView
            }
        }
        .padding()
        .navigationTitle(diningHall.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            locationManager.requestPermission()
            if locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways {
                locationManager.requestLocation()
            }
        }
        .onDisappear {
            shakeDetector.stopMonitoring()
        }
        .onChange(of: shakeDetector.shakeDetected) { _, detected in
            if detected {
                vm.collect(diningHall)
                justCollected = true
            }
        }
    }

    // MARK: - Subviews

    private var collectedView: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 80))
                .foregroundStyle(.green)
            Text(justCollected ? "Collected!" : "Already collected!")
                .font(.title2.bold())
        }
    }

    private var permissionDeniedView: some View {
        VStack(spacing: 12) {
            Image(systemName: "location.slash.fill")
                .font(.system(size: 60))
                .foregroundStyle(.red)
            Text("Location access is required to collect dining halls.")
                .font(.headline)
                .multilineTextAlignment(.center)
            Text("Please enable location access in Settings.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private func locationErrorView(_ error: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.orange)
            Text("Location error: \(error)")
                .font(.subheadline)
                .multilineTextAlignment(.center)
            Button("Retry") {
                locationManager.requestLocation()
            }
            .buttonStyle(.borderedProminent)
        }
    }

    private var tooFarView: some View {
        VStack(spacing: 12) {
            Image(systemName: "location.fill")
                .font(.system(size: 60))
                .foregroundStyle(.orange)
            Text("You're too far away!")
                .font(.title2.bold())
            if let distance = locationManager.distanceToHall(diningHall) {
                Text("You are \(Int(distance))m away. Get within 50m to collect.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Button("Check Again") {
                locationManager.requestLocation()
            }
            .buttonStyle(.borderedProminent)
        }
    }

    private var nearbyView: some View {
        VStack(spacing: 16) {
            if shakeDetector.isAvailable {
                Image(systemName: "iphone.radiowaves.left.and.right")
                    .font(.system(size: 60))
                    .foregroundStyle(.blue)
                Text("You're nearby!")
                    .font(.title2.bold())
                Text("Shake your device to collect this dining hall.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            } else {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.orange)
                Text("Accelerometer not available.")
                    .font(.headline)
                Text("Shake detection requires a physical device.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .onAppear {
            shakeDetector.startMonitoring()
        }
    }
}
