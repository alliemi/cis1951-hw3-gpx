//
//  hw3App.swift
//  hw3
//
//  Created by Tim Liang on 3/24/26.
//

import SwiftUI

@main
struct hw3App: App {
    var body: some Scene {
        @State var diningHallViewModel = DiningHallViewModel()
        
        WindowGroup {
            HomeView()
                .environment(diningHallViewModel)
        }
    }
}
