//
//  MealRow.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI

struct MealRow: View {
    let meal: Meals.Meal
    
    var body: some View {
        RoundedRectangle(cornerRadius: Constant.MealRow.roundedRecCornerRadius)
            .fill(.white)
            .shadow(color: .gray.opacity(Constant.MealRow.shadowOpacity), radius: Constant.MealRow.shadowRadius, x: Constant.MealRow.shadowOffset, y: Constant.MealRow.shadowOffset)
            .overlay {
                HStack {
                    dessertImage
                    Text(meal.strMeal)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.orange.opacity(Constant.MealRow.chevronColorOpacity))
                }
                .padding(Constant.MealRow.overlayPadding)
            }
            .frame(height: Constant.MealRow.roundedRecHeight)
    }
    
    private var dessertImage: some View {
        AsyncImage(url: URL(string: meal.strMealThumb)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(.buttonBorder)
            } else if phase.error != nil {
                Image(systemName: "exclamationmark.icloud")
            } else {
                ProgressView()
            }
        }
        .frame(width: Constant.MealRow.imageSize, height: Constant.MealRow.imageSize)
    }
}
