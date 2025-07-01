//
//  WelcomeView.swift
//  triplux
//
//  Created by Dario Daßler on 01.07.25.
//

import SwiftUI

struct WelcomeView: View {
    
    @Binding var begin: Bool
    
    var body: some View {
        VStack {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .padding(.bottom, -50)
            Text("triplux")
                .font(.largeTitle)
                .fontWeight(.heavy)
            HStack(spacing: 4) {
                Image(systemName: "map")
                Text("Planen ")
                Image(systemName: "backpack")
                Text("Entdecken ")
                Image(systemName: "mountain.2")
                Text("Erleben ")
            }
            .font(.headline)
            .padding(.bottom, 20)
            
            Text("Du stehst am Anfang deiner nächsten großen Reise. Egal, ob du den höchsten Gipfel erklimmen, durch fremde Städte streifen oder einfach dem Alltag entfliehen willst – triplux begleitet dich von der ersten Idee bis zum letzten Schritt deiner Route.")
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            Spacer()
            
            Button("Dein Abenteuer beginnt hier!", systemImage: "safari.fill") {
                begin.toggle()
            }.buttonStyle(.borderedProminent)
            .fontWeight(.bold)
            
            Spacer()
        }
        .fontDesign(.rounded)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.secondaryAccent)
    }
}

#Preview {
    @Previewable @State var toggle: Bool = false
    WelcomeView(begin: $toggle)
}
