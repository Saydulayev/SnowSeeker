//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Saydulayev on 11.02.25.
//

import SwiftUI

enum SortingOption: String, CaseIterable {
    case `default` = "Default"
    case alphabetical = "Alphabetical"
    case country = "Country"
}

struct ContentView: View {
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var favorites = Favorites()
    @State private var searchText = ""
    @State private var sortingOption: SortingOption = .default
    
    var filteredResorts: [Resort] {
        let filtered = searchText.isEmpty
            ? resorts
            : resorts.filter { $0.name.localizedStandardContains(searchText) }
        
        switch sortingOption {
        case .default:
            return filtered
        case .alphabetical:
            return filtered.sorted { $0.name < $1.name }
        case .country:
            return filtered.sorted { $0.country < $1.country }
        }
    }

    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )

                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        ForEach(SortingOption.allCases, id: \.self) { option in
                            Button(option.rawValue) {
                                sortingOption = option
                            }
                        }
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}

