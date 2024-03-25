//
//  IngredientRow.swift
//  Recipes
//
//  Created by CJ on 3/5/24.
//

import SwiftUI

struct IngredientRow: View {
    @State private var image: UIImage?
    var manager: MealDetailManager
    let ingredient: String
    let measure: String
    let theme: Color
    
    var body: some View {
        HStack {
            ingredientImage
                .padding(.vertical, 4)
            Text(ingredient)
            Spacer()
            Text(measure)
        }
        .padding(.horizontal)
        .frame(height: 48)
        .background(RoundedRectangle(cornerRadius: 8).fill(theme.opacity(0.1)))
        .task {
            image = await manager.fetchIngredientImage(ingredient)
        }
    }
    
    private var ingredientImage: some View {
        Image(uiImage: image ?? UIImage())
            .resizable()
            .scaledToFit()
            .clipShape(.buttonBorder)
    }
}
