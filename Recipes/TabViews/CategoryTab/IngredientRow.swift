//
//  IngredientRow.swift
//  Recipes
//
//  Created by CJ on 3/5/24.
//

import SwiftUI

struct IngredientRow: View {
    @Environment(ImageRetriever.self) private var retriever
    @State private var image: UIImage?
    var manager: MealDetailManager
    let ingredient: String
    let measure: String
    let theme: Color
    
    var body: some View {
        HStack {
            ingredientImage
                .padding(.vertical, Constant.IngredientRow.imagePadding)
            Text(ingredient)
            Spacer()
            Text(measure)
        }
        .padding(.horizontal)
        .frame(height: Constant.IngredientRow.rowHeight)
        .background(RoundedRectangle(cornerRadius: Constant.IngredientRow.cornerRadius).fill(theme.opacity(Constant.IngredientRow.themeOpacity)))
        .task {
            image = await retriever.fetchIngredientImage(ingredient)
        }
    }
    
    private var ingredientImage: some View {
        Image(uiImage: image ?? UIImage())
            .resizable()
            .scaledToFit()
            .clipShape(.buttonBorder)
    }
}
