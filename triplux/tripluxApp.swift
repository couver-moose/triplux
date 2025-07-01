//
//  tripluxApp.swift
//  triplux
//
//  Created by Dario Daßler on 01.07.25.
//

import SwiftUI
import SwiftData

@main
struct tripluxApp: App {
    var body: some Scene {
        WindowGroup {
            Start()
                .modelContainer(for: [Pin.self])
        }
    }
}
