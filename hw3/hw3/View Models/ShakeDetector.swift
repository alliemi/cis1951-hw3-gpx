//
//  ShakeDetector.swift
//  hw3
//
//  Created by Allison Mi on 3/24/26.
//

import Foundation
import CoreMotion

@Observable class ShakeDetector {
    private let motionManager = CMMotionManager()
    private var shakeCount = 0
    private var lastShakeTime: Date?

    var shakeDetected = false
    var isAvailable: Bool { motionManager.isAccelerometerAvailable }

    private let shakeThreshold: Double = 2.5
    private let requiredShakes = 3
    private let shakeWindow: TimeInterval = 2.0
    private let debounceCooldown: TimeInterval = 0.3

    func startMonitoring() {
        guard motionManager.isAccelerometerAvailable else { return }
        reset()

        motionManager.accelerometerUpdateInterval = 1.0 / 60.0
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, error in
            guard let self, let data else { return }
            self.processAcceleration(data.acceleration)
        }
    }

    func stopMonitoring() {
        motionManager.stopAccelerometerUpdates()
    }

    func reset() {
        shakeDetected = false
        shakeCount = 0
        lastShakeTime = nil
    }

    private func processAcceleration(_ acceleration: CMAcceleration) {
        let magnitude = sqrt(
            acceleration.x * acceleration.x +
            acceleration.y * acceleration.y +
            acceleration.z * acceleration.z
        )

        guard magnitude > shakeThreshold else { return }

        let now = Date()

        if let lastTime = lastShakeTime, now.timeIntervalSince(lastTime) > shakeWindow {
            shakeCount = 0
        }

        guard lastShakeTime == nil || now.timeIntervalSince(lastShakeTime!) > debounceCooldown else {
            return
        }

        shakeCount += 1
        lastShakeTime = now

        if shakeCount >= requiredShakes {
            shakeDetected = true
            stopMonitoring()
        }
    }
}
