//
//  HomeView.swift
//  hw3
//
//  Created by Tim Liang on 3/24/26.
//

import SwiftUI

struct HomeView: View {
    @Environment(DiningHallViewModel.self) var vm

    var body: some View {
        NavigationStack {
            List(vm.diningHalls) { hall in
                NavigationLink(value: hall.id) {
                    HStack {
                        Text(hall.name)
                        Spacer()
                        if vm.isCollected(hall) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        }
                    }
                }
            }
            .navigationDestination(for: UUID.self) { id in
                if let hall = vm.diningHalls.first(where: { $0.id == id }) {
                    DiningHallView(diningHall: hall)
                }
            }
            .navigationTitle("Scavenger Hunt")
        }
    }
}

#Preview {
    HomeView()
        .environment(DiningHallViewModel())
}
