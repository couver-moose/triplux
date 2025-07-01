//
//  Utils.swift
//  triplux
//
//  Created by Dario Daßler on 01.07.25.
//

struct Utils {
    static func flagEmoji(for countryCode: String) -> String {
        countryCode
            .uppercased()
            .unicodeScalars
            .compactMap { UnicodeScalar(127397 + $0.value) }
            .map { String($0) }
            .joined()
    }
}
