//
//  Start.swift
//  triplux
//
//  Created by Dario Daßler on 01.07.25.
//

import SwiftUI

struct Start: View {
    
    @State private var beginAdventure: Bool = false
    
    var body: some View {
        WelcomeView(begin: $beginAdventure)
        .fullScreenCover(isPresented: $beginAdventure) {
            NavigationStack {
                AdventureMap()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Zurück zum Start", systemImage: "chevron.left") {
                            beginAdventure = false
                        }
                    }
                }
                .toolbarBackgroundVisibility(.hidden)
            }
        }
    }
}

#Preview {
    Start()
        .modelContainer(for: [Pin.self], inMemory: true)
}
