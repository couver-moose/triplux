//
//  PinView.swift
//  triplux
//
//  Created by Dario Daßler on 04.07.25.
//

import SwiftUI

struct PinView: View {
    let pin: Pin
    
    var body: some View {
        HStack {
            Text(pin.flag)
            
            VStack(alignment: .leading) {
                Text(pin.name)
                let country = pin.country.isEmpty ? pin.name : pin.country
                if country != pin.name {
                    let cityName = pin.city.isEmpty ? pin.name : pin.city
                    let area = cityName != pin.name ? "\(cityName), \(country)" : country
                    Text(area)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
    
    private func flagEmoji(for countryCode: String) -> String {
        countryCode
            
    }
}
