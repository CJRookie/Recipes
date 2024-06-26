//
//  ContentView.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selection: Tab = .category
    @Environment(FavoriteListManager.self) private var manager
    
    enum Tab: String {
        case category
        case favorite
        
        var title: String {
            rawValue.capitalized
        }
    }
    
    var body: some View {
        TabView(selection: $selection) {
            CategoryGallery()
                .tabItem {
                    Image(systemName: "waveform")
                }
                .tag(Tab.category)
            FavoriteList()
                .tabItem {
                    Image(systemName: "heart.fill")
                }
                .tag(Tab.favorite)
        }
        .task {
            manager.fetchFavoriteRecipes()
        }
    }
}
