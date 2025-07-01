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
    
    private static let defaultPosition : MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 45, longitude: 5),
        span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)))
    
    @State private var position : MapCameraPosition = defaultPosition
    
    var body: some View {
        Map(position: $position) {
            ForEach(pins, id: \.self) { pin in
                Marker(pin.name, systemImage: "pin", coordinate: pin.coordinate())
                    .tint(Color.accentColor)
            }
        }
        .mapStyle(.hybrid)
    }
}
