//
//  MealRow.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI

struct MealRow: View {
    @Environment(ImageCenter.self) private var imageCenter
    @State private var image: UIImage?
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
            image = await imageCenter.getImage(from: meal.thumb) ?? UIImage()
        }
    }
    
    private var dessertImage: some View {
        Image(uiImage: image ?? UIImage())
            .resizable()
            .scaledToFit()
            .clipShape(.buttonBorder)
    }
}
