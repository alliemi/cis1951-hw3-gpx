//
//  hw3App.swift
//  hw3
//
//  Created by Tim Liang on 3/24/26.
//

import SwiftUI

@main
struct hw3App: App {
    @State private var diningHallViewModel = DiningHallViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(diningHallViewModel)
        }
    }
}
