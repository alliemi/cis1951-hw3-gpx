//
//  DiningHallView.swift
//  hw3
//
//  Created by Tim Liang on 3/24/26.
//

import SwiftUI

struct DiningHallView: View {
    @Environment(DiningHallViewModel.self) var vm
    
    var body: some View {
        VStack {
            if vm.currentDiningHall!.isCollected {
                Text("You have already collected this dining hall.")
            }
        }
        .navigationTitle(vm.currentDiningHall!.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
