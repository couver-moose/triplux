//
//  Start.swift
//  triplux
//
//  Created by Dario Daßler on 01.07.25.
//

import SwiftUI

struct Start: View {
    var body: some View {
        AdventureMap()
    }
}

#Preview {
    Start()
        .modelContainer(for: [Pin.self], inMemory: true)
}
