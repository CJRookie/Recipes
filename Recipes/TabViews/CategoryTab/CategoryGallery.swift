//
//  CategoryGallery.swift
//  Recipes
//
//  Created by CJ on 3/21/24.
//

import SwiftUI

struct CategoryGallery: View {
    @Environment(FavoriteListManager.self) private var favoritesManager
    @Environment(CategoryManager.self) private var manager
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                    ForEach(0..<manager.categories.count / 2, id: \.self) { index in
                        GridRow {
                            NavigationLink(value: manager.categories[index * 2]) {
                                CategoryCard(category: manager.categories[index * 2])
                            }
                            NavigationLink(value: manager.categories[index * 2 + 1]) {
                                CategoryCard(category: manager.categories[index * 2 + 1])
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Category")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Category.self) { category in
                MealList(category: category.name)
            }
        }
        .task {
            await manager.fetchCategories()
        }
        .onAppear {
            favoritesManager.getFavoriteRecipes()
        }
    }
}
