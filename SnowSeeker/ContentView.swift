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
                    VStack(spacing: 0) {
                        HStack(spacing: 12) {
                            Image(resort.country)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 32)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.quaternary, lineWidth: 0.5)
                                )
                                .shadow(radius: 2)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(resort.name)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                
                                HStack(spacing: 8) {
                                    Label("\(resort.runs) runs", systemImage: "figure.skiing.downhill")
                                        .foregroundStyle(.secondary)
                                        .font(.subheadline)
                                    
                                    Text("•")
                                        .foregroundStyle(.secondary)
                                    
                                    Label("\(resort.elevation)m", systemImage: "mountain.2")
                                        .foregroundStyle(.secondary)
                                        .font(.subheadline)
                                }
                            }
                            
                            Spacer()
                            
                            if favorites.contains(resort) {
                                Image(systemName: "heart.fill")
                                    //.symbolEffect(.pulse)
                                    .foregroundStyle(.red)
                                    .font(.title3)
                            }
                        }
                        .padding(.vertical, 8)
                        
                        Divider()
                            .background(Color.gray.opacity(0.2))
                    }
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
            .listStyle(.plain)
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

