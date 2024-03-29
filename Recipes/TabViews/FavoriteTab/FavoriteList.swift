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
        NavigationStack {
            Group {
                if !manager.recipes.isEmpty {
                    ListTemplate(list: manager.recipes, navTitle: "Favorite")
                }
            }
        }
    }
}
