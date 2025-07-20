//
//  PinModel.swift
//  triplux
//
//  Created by Dario Daßler on 01.07.25.
//

import SwiftData
import MapKit

@Model
class Pin {
    var name: String
    var city: String
    var country: String
    
    var countryCode: String
    var flag: String {
        self.countryCode
        .uppercased()
        .unicodeScalars
        .compactMap { UnicodeScalar(127397 + $0.value) }
        .map { String($0) }
        .joined()
    }
    
    var lat: Double
    var lon: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.lat, longitude: self.lon)
    }
    
    init(mapItem: MKMapItem) {
        self.name = mapItem.name ?? ""
        self.city = mapItem.placemark.locality ?? ""
        self.country = mapItem.placemark.country ?? ""
        self.countryCode = mapItem.placemark.countryCode ?? ""
        self.lat = mapItem.placemark.coordinate.latitude
        self.lon = mapItem.placemark.coordinate.longitude
    }
    
}
