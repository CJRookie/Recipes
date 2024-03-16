//
//  MealRow.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI

struct MealRow: View {
    @Environment(MealsManager.self) private var manager
    @State private var image = UIImage()
    let meal: Meals.Meal
    
    var body: some View {
        RoundedRectangle(cornerRadius: Constant.MealRow.roundedRecCornerRadius)
            .fill(.white)
            .shadow(color: .gray.opacity(Constant.MealRow.shadowOpacity), radius: Constant.MealRow.shadowRadius, x: Constant.MealRow.shadowOffset, y: Constant.MealRow.shadowOffset)
            .overlay {
                HStack {
                    dessertImage
                    Text(meal.meal)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.orange.opacity(Constant.MealRow.chevronColorOpacity))
                }
                .padding(Constant.MealRow.overlayPadding)
            }
            .frame(height: Constant.MealRow.roundedRecHeight)
            .task {
                image = await manager.getImage(from: meal.mealThumb) ?? UIImage()
            }
    }
    
    private var dessertImage: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .clipShape(.buttonBorder)
            .frame(width: Constant.MealRow.imageSize, height: Constant.MealRow.imageSize)
    }
}
