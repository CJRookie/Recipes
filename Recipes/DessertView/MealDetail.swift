//
//  MealDetail.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI

struct MealDetail: View {
    @State private var themes: [Color] = [Color.green, Color.orange, Color.blue, Color.pink, Color.yellow, Color.purple]
    @State private var manager: MealDetailManager
    @State private var image = UIImage()
    
    init(_ meal: Meals.Meal) {
        _manager = State(initialValue: MealDetailManager(meal))
    }

    var body: some View {
        detail
            .ignoresSafeArea(edges: .top)
            .task {
                await manager.fetchMealDetail()
                image = await manager.getImage(from: manager.meal.strMealThumb) ?? UIImage()
            }
    }
    
    @ViewBuilder
    private var detail: some View {
        if manager.mealDetail != nil {
            VStack(spacing: Constant.MealDetail.outermostVStackSpacing) {
                dessertImage
                ZStack {
                    RoundedRectangle(cornerRadius: Constant.MealDetail.cornerRadius)
                        .fill(.white.opacity(Constant.MealDetail.roundedRecOpacity))
                    ScrollView {
                        VStack(spacing: Constant.MealDetail.mainContentVStackSpacing) {
                            headingSection
                            ingredientsSection
                            instructionsSection
                        }
                    }
                    .padding(.bottom)
                    .clipShape(RoundedRectangle(cornerRadius: Constant.MealDetail.cornerRadius))
                }
            }
            .scrollIndicators(.hidden)
        } else {
            VStack(spacing: Constant.MealDetail.outermostVStackSpacing) {
                dessertImage
                ZStack {
                    RoundedRectangle(cornerRadius: Constant.MealDetail.cornerRadius)
                        .fill(.white.opacity(Constant.MealDetail.roundedRecOpacity))
                    Text("Instructions will be added soon.")
                }
            }
        }
    }
    
    private var headingSection: some View {
        Text(manager.mealDetail?.strMeal ?? "")
            .font(.system(size: Constant.MealDetail.headingSecFontSize, weight: .semibold))
            .padding(.top, Constant.MealDetail.headingSecTopPadding)
    }

    private var ingredientsSection: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {
                Text("Ingredients")
                    .font(.system(size: Constant.MealDetail.subtitleFontSize, weight: .medium))
                Spacer()
                Text("\(manager.mealDetail?.strIngredients.count ?? 0) Item(s)")
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal)

            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<(manager.mealDetail?.strIngredients.count ?? 0), id: \.self) { index in
                        if let ingredient = manager.mealDetail?.strIngredients[index], let measure = manager.mealDetail?.strMeasures[index] {
                            IngredientCard(ingredient: ingredient, measure: measure, theme: themes[index % themes.count])
                        }
                    }
                }
                .padding(.leading)
            }
        }
    }

    private var instructionsSection: some View {
        VStack(alignment: .leading, spacing: Constant.MealDetail.instructionsSecSpacing) {
            Text("Instructions")
                .font(.system(size: Constant.MealDetail.subtitleFontSize, weight: .medium))
            Text(manager.mealDetail?.strInstructions ?? "")
        }
        .padding(.horizontal)
    }

    private var dessertImage: some View {
        ZStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .clipShape(.buttonBorder)
            LinearGradient(gradient: Gradient(colors: [.clear, .white]), startPoint: .top, endPoint: .bottom)
        }
        .frame(height: Constant.MealDetail.imageHeight)
    }
}
    
