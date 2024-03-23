//
//  MealRow.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI

struct MealRow: View {
    @Environment(ImageCacheCenter.self) private var imageCache
    @State private var image = UIImage()
    let meal: Meal
    
    var body: some View {
        HStack {
            dessertImage
            Text(meal.name)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.orange.opacity(Constant.MealRow.chevronColorOpacity))
        }
        .padding(Constant.MealRow.overlayPadding)
        .glowRoundedRect(rectHeight: Constant.MealRow.roundedRecHeight, glowColor: .gray.opacity(Constant.MealRow.shadowOpacity))
        .task {
            if let url = URL(string: meal.thumb) {
                image = await imageCache.getRecipeImage(from: url) ?? UIImage()
            }
        }
    }
    
    private var dessertImage: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .clipShape(.buttonBorder)
    }
}
