//
//  FavoriteList.swift
//  Recipes
//
//  Created by CJ on 3/20/24.
//

import SwiftUI

struct FavoriteList: View {
    @Environment(FavoriteListManager.self) private var manager
    
    var body: some View {
        List(manager.favoriteRecipes, id: \.self) { recipe in
            Text(recipe)
        }
        .listStyle(.plain)
    }
}
