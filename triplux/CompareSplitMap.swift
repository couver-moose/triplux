//
//  CompareSplitMap.swift
//  triplux
//
//  Created by Dario Daßler on 08.09.25.
//

import SwiftUI
import MapKit

struct CompareSplitMap: View {
    
    static let minDistance: Double = 20000
    static let maxDistance: Double = 20000000
    
    
    @State private var distanceMeters: Double = maxDistance
    
    @State private var position: MapCameraPosition = .camera(
        MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: 45, longitude: 5),
                  distance: maxDistance,
                  heading: 0,
                  pitch: 0)
    )
    
    @State private var positionTwo: MapCameraPosition = .camera(
        MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: 45, longitude: 5),
                  distance: maxDistance,
                  heading: 0,
                  pitch: 0)
    )
    
    @State private var center = CLLocationCoordinate2D(latitude: 45, longitude: 5)
    @State private var centerTwo = CLLocationCoordinate2D(latitude: 45, longitude: 5)
    
    @State private var pin: Pin?
    @State private var pinTwo: Pin?
    
    @State private var showAddPin: Bool = false
    @State private var showAddPinTwo: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Map(position: $position, interactionModes: .pan) {
                if let pin = pin {
                    Marker(pin.name, systemImage: "pin", coordinate: pin.coordinate)
                        .tint(Color.marker)
                }
            }
            Map(position: $positionTwo, interactionModes: .pan) {
                if let pin = pinTwo {
                    Marker(pin.name, systemImage: "pin", coordinate: pin.coordinate)
                        .tint(Color.marker)
                }
            }
        }
        .mapStyle(.hybrid)
        .overlay(alignment: .bottom) {
            VStack {
                Spacer()
                HStack(spacing: 10) {
                    Image(systemName: "minus.magnifyingglass")
                    Slider(value: $distanceMeters, in: CompareSplitMap.minDistance...CompareSplitMap.maxDistance, step: 10) {
                        Text("Zoom")
                    }
                    .frame(maxWidth: 280)
                    .onChange(of: distanceMeters) {
                        position = .camera(MapCamera(centerCoordinate: center,
                                                     distance: distanceMeters,
                                                     heading: 0,
                                                     pitch: 0))
                        positionTwo = .camera(MapCamera(centerCoordinate: centerTwo,
                                                        distance: distanceMeters,
                                                        heading: 0,
                                                        pitch: 0))
                    }
                    Image(systemName: "plus.magnifyingglass")
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial, in: Capsule())
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Erster Ort", systemImage: "1.circle.fill") {
                    showAddPin.toggle()
                }.buttonStyle(.borderedProminent)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Zweiter Ort", systemImage: "2.circle.fill") {
                    showAddPinTwo.toggle()
                }.buttonStyle(.borderedProminent)
            }
        }
        .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
        .fullScreenCover(isPresented: $showAddPin) {
            AddPinView(add: addPin)
        }
        .fullScreenCover(isPresented: $showAddPinTwo) {
            AddPinView(add: addPinTwo)
        }
    }
    
    private func addPin(_ pin: Pin) {
        self.pin = pin
        center = pin.coordinate
        position = .camera(MapCamera(centerCoordinate: center,
                                     distance: distanceMeters,
                                     heading: 0,
                                     pitch: 0))
    }
    
    private func addPinTwo(_ pinTwo: Pin) {
        self.pinTwo = pinTwo
        centerTwo = pinTwo.coordinate
        positionTwo = .camera(MapCamera(centerCoordinate: centerTwo,
                                        distance: distanceMeters,
                                        heading: 0,
                                        pitch: 0))
    }
}

#Preview {
    NavigationStack {
        CompareSplitMap()
    }
}
