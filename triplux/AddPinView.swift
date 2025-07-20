//
//  AddPinView.swift
//  triplux
//
//  Created by Dario Daßler on 11.07.25.
//

import SwiftUI
import MapKit
import SwiftData

struct AddPinView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query var pins: [Pin]
    
    let add : (Pin) -> Void
    
    @State private var searchText = ""
    @State private var searchResults: [MKMapItem] = []

    var body: some View {
        NavigationStack {
            List {
                if searchResults.isEmpty {
                    ContentUnavailableView("Durchsuche die ganze Welt!", systemImage: "safari")
                        .foregroundStyle(.secondaryAccent)
                        .listRowBackground(Color.clear)
                } else {
                    ForEach(searchResults, id: \.self) { mapItem in
                        let pin = Pin(mapItem: mapItem)
                        Button {
                            modelContext.insert(pin)
                            add(pin)
                            dismiss()
                        } label: {
                            PinView(pin: pin)
                        }.buttonStyle(.borderless)
                        .foregroundStyle(.primary)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Dein Reiseziel suchen")
            .navigationTitle("Reiseziel hinzufügen")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                }
            }
            .onChange(of: searchText) {
                searchLocations()
            }
        }
    }

    private func searchLocations() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            let results = response?.mapItems ?? []
            DispatchQueue.main.async {
                searchResults = results
            }
        }
    }
}
