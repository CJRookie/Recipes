//
//  ListTemplate.swift
//  Recipes
//
//  Created by CJ on 3/26/24.
//

import SwiftUI

struct ListTemplate: View {
    @State private var text: String = ""
    let list: [Meal]
    let navTitle: String
    
    var currentList: [Meal] {
        MealListOperation.filter(list, by: text)
    }
    
    var body: some View {
        List(currentList) { meal in
            ZStack {
                MealRow(meal: meal)
                NavigationLink(value: meal) {
                    EmptyView()
                }
                .opacity(0)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle(navTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Meal.self) { meal in
            MealDetail(meal: meal)
        }
        .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by name")
    }
}
