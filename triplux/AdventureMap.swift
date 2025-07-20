//
//  AdventureMap.swift
//  triplux
//
//  Created by Dario Daßler on 01.07.25.
//

import SwiftUI
import MapKit
import SwiftData

struct AdventureMap: View {
    
    @Query var pins : [Pin]
    
    private static let lowDetent: PresentationDetent = .fraction(0.05)
    
    @AppStorage("showStart") private var showStart: Bool = true
    @State private var sheetDetent: PresentationDetent = .medium
    @State private var showAddCity = false
    
    private static let defaultPosition : MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 45, longitude: 5),
        span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)))
    
    @State private var position : MapCameraPosition = defaultPosition
    
    var body: some View {
        Map(position: $position) {
            ForEach(pins, id: \.self) { pin in
                Marker(pin.name, systemImage: "pin", coordinate: pin.coordinate)
                    .tint(Color.accentColor)
            }
        }
        .mapStyle(.hybrid)
        .sheet(isPresented: .constant(true)) {
            NavigationStack {
                List {
                    if pins.isEmpty {
                        ContentUnavailableView("Speichere jetzt dein erstes Reiseziel", systemImage: "pin")
                            .foregroundStyle(.secondaryAccent)
                            .listRowBackground(Color.clear)
                    } else {
                        ForEach(pins, id: \.self) { pin in
                            Button {
                                withAnimation(.smooth) {
                                    sheetDetent = AdventureMap.lowDetent
                                    position = .region(MKCoordinateRegion(
                                        center: pin.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
                                    ))
                                }
                            } label: {
                                PinView(pin: pin)
                            }.buttonStyle(.borderless)
                            .foregroundStyle(.primary)
                        }
                    }
                }
                .listRowSpacing(10)
                .navigationTitle("Deine Reiseziele")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showAddCity = true
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Zurück zum Start", systemImage: "info.circle.fill") {
                            showStart = true
                        }
                    }
                }
                .fullScreenCover(isPresented: $showAddCity) {
                    AddPinView(add: addPin)
                }
            }
            .presentationDetents([.medium, AdventureMap.lowDetent], selection: $sheetDetent)
            .presentationDragIndicator(.hidden)
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(30)
            .presentationBackgroundInteraction(.enabled(upThrough: AdventureMap.lowDetent))
            .interactiveDismissDisabled(true)
            .fullScreenCover(isPresented: $showStart) {
                WelcomeView(begin: $showStart)
            }
        }
    }
    
    private func addPin(_ pin: Pin) {
        withAnimation(.smooth) {
            sheetDetent = AdventureMap.lowDetent
            position = .region(MKCoordinateRegion(
                center: pin.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
            ))
        }
    }
}
