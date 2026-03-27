//
//  HomeView.swift
//  hw3
//
//  Created by Tim Liang on 3/24/26.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @Environment(DiningHallViewModel.self) var vm
    @State private var locationManager = LocationManager()
    @State private var showPermissionSheet = false
    @State private var path: [UUID] = []

    @State private var savedPosition: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.9527, longitude: -75.1960),
        span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
    ))
    @State private var position: MapCameraPosition = .automatic

    var body: some View {
        NavigationStack(path: $path) {
            Map(position: $position) {
                UserAnnotation()

                ForEach(vm.diningHalls) { hall in
                    Annotation(hall.name, coordinate: hall.location.coordinate) {
                        Button {
                            path.append(hall.id)
                        } label: {
                            Image(systemName: vm.isCollected(hall) ? "checkmark.circle.fill" : "fork.knife.circle.fill")
                                .font(.title2)
                                .foregroundStyle(vm.isCollected(hall) ? .green : .red)
                                .padding(4)
                                .background(Circle().fill(.white))
                        }
                    }
                }
            }
            .id(vm.collectedIDs)
            .mapStyle(.standard)
            .navigationDestination(for: UUID.self) { id in
                if let hall = vm.diningHalls.first(where: { $0.id == id }) {
                    DiningHallView(diningHall: hall)
                }
            }
            .navigationTitle("Scavenger Hunt")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if locationManager.authorizationStatus == .notDetermined {
                    showPermissionSheet = true
                }
                position = savedPosition
            }
            .onMapCameraChange { context in
                savedPosition = .camera(context.camera)
            }
            .sheet(isPresented: $showPermissionSheet, onDismiss: {
                locationManager.requestPermission()
            }) {
                VStack(spacing: 20) {
                    Image(systemName: "location.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.blue)

                    Text("Location Access Needed")
                        .font(.title2.bold())

                    Text("This app uses your location to check if you're near a dining hall so you can collect it in the scavenger hunt.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)

                    Button("Continue") {
                        showPermissionSheet = false
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(30)
                .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(DiningHallViewModel())
}
