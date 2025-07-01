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
    var flag: String
    var lat: Double
    var lon: Double
    
    func coordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    init (name: String, city: String, country: String, flag: String, lat: Double, lon: Double) {
        self.name = name
        self.city = city
        self.country = country
        self.flag = flag
        self.lat = lat
        self.lon = lon
    }
    
    init(mapItem: MKMapItem) {
        self.name = mapItem.name ?? ""
        self.city = mapItem.placemark.locality ?? ""
        self.country = mapItem.placemark.country ?? ""
        self.flag = Utils.flagEmoji(for: mapItem.placemark.countryCode ?? "")
        self.lat = mapItem.placemark.coordinate.latitude
        self.lon = mapItem.placemark.coordinate.longitude
    }
}
