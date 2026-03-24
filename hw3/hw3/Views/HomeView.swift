//
//  HomeView.swift
//  hw3
//
//  Created by Tim Liang on 3/24/26.
//

import SwiftUI

struct HomeView: View {
    @Environment(DiningHallViewModel.self) var vm
    @State var path: [String] = []

    var body: some View {
        NavigationStack(path: $path) {
            List(vm.diningHalls) { diningHall in
                Button(diningHall.name) {
                    path.append(diningHall.name)
                    vm.currentDiningHall = diningHall
                }
            }
            .navigationDestination(for: String.self) { _ in
                DiningHallView()
                    .environment(vm)
            }
            .navigationTitle("Scavenger Hunt")
        }
    }
}

#Preview {
    HomeView()
        .environment(DiningHallViewModel())
}
