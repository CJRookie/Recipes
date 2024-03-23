//
//  IngredientCard.swift
//  Recipes
//
//  Created by CJ on 3/5/24.
//

import SwiftUI

struct IngredientCard: View {
    let ingredient: String
    let measure: String
    let theme: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constant.IngredientCard.cornerRadius)
                .fill(theme.opacity(Constant.IngredientCard.themeOpacity))
            VStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: Constant.IngredientCard.cornerRadius)
                        .fill(theme.opacity(Constant.IngredientCard.themeOpacity))
                    Text(ingredient)
                        .lineLimit(Constant.IngredientCard.textLineLimit)
                }
                Text(measure)
                    .padding(.vertical, Constant.IngredientCard.measureVPadding)
            }
        }
        .frame(width: Constant.IngredientCard.size, height: Constant.IngredientCard.size)
        .padding(.trailing, Constant.IngredientCard.trailingPadding)
    }
}
