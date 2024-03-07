//
//  MealDetail.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI

struct MealDetail: View {
    @State private var themes: [Color] = [Color.green, Color.orange, Color.blue, Color.pink, Color.yellow, Color.purple]
    let mealDetail: Meal.Detail
    
    var body: some View {
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
        .ignoresSafeArea(edges: .top)
    }
    
    private var headingSection: some View {
        Text(mealDetail.strMeal)
            .font(.system(size: Constant.MealDetail.headingSecFontSize, weight: .semibold))
            .padding(.top, Constant.MealDetail.headingSecTopPadding)
    }
    
    private var ingredientsSection: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {
                Text("Ingredients")
                    .font(.system(size: Constant.MealDetail.subtitleFontSize, weight: .medium))
                Spacer()
                Text("\(mealDetail.strIngredients.count) Item(s)")
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<mealDetail.strIngredients.count, id: \.self) { index in
                        IngredientCard(ingredient: mealDetail.strIngredients[index], measure: mealDetail.strMeasures[index], theme: themes[index % themes.count])
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
            Text(mealDetail.strInstructions)
        }
        .padding(.horizontal)
    }
    
    private var dessertImage: some View {
        ZStack {
            AsyncImage(url: URL(string: mealDetail.strMealThumb)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(.buttonBorder)
                } else {
                    Color.red
                }
            }
            LinearGradient(gradient: Gradient(colors: [.clear, .white]), startPoint: .top, endPoint: .bottom)
        }
        .frame(height: Constant.MealDetail.imageHeight)
    }
//    @State private var manager: MealDetailManager
//    @State private var themes: [Color] = [Color.green, Color.orange, Color.blue, Color.pink, Color.yellow, Color.purple]
//    
//    init(_ meal: Meals.Meal) {
//        _manager = State(initialValue: MealDetailManager(meal))
//    }
//    
//    var body: some View {
//        VStack(spacing: Constant.MealDetail.outermostVStackSpacing) {
//            dessertImage
//            ZStack {
//                RoundedRectangle(cornerRadius: Constant.MealDetail.cornerRadius)
//                    .fill(.white.opacity(Constant.MealDetail.roundedRecOpacity))
//                ScrollView {
//                    VStack(spacing: Constant.MealDetail.mainContentVStackSpacing) {
//                        headingSection
//                        ingredientsSection
//                        instructionsSection
//                    }
//                }
//                .padding(.bottom)
//                .clipShape(RoundedRectangle(cornerRadius: Constant.MealDetail.cornerRadius))
//            }
//        }
//        .scrollIndicators(.hidden)
//        .ignoresSafeArea(edges: .top)
//        .task {
//            await manager.fetchMealDetail()
//        }
//    }
//    
//    private var headingSection: some View {
//        Text(manager.mealDetail?.strMeal ?? "")
//            .font(.system(size: Constant.MealDetail.headingSecFontSize, weight: .semibold))
//            .padding(.top, Constant.MealDetail.headingSecTopPadding)
//    }
//    
//    private var ingredientsSection: some View {
//        VStack {
//            HStack(alignment: .lastTextBaseline) {
//                Text("Ingredients")
//                    .font(.system(size: Constant.MealDetail.subtitleFontSize, weight: .medium))
//                Spacer()
//                Text("\(manager.mealDetail?.strIngredients.count ?? 0) Item(s)")
//                    .foregroundStyle(.gray)
//            }
//            .padding(.horizontal)
//            
//            ScrollView(.horizontal) {
//                HStack {
//                    ForEach(0..<(manager.mealDetail?.strIngredients.count ?? 0), id: \.self) { index in
//                        if let ingredient = manager.mealDetail?.strIngredients[index], let measure = manager.mealDetail?.strMeasures[index] {
//                            IngredientCard(ingredient: ingredient, measure: measure, theme: themes[index % themes.count])
//                        }
//                    }
//                }
//                .padding(.leading)
//            }
//        }
//    }
//    
//    private var instructionsSection: some View {
//        VStack(alignment: .leading, spacing: Constant.MealDetail.instructionsSecSpacing) {
//            Text("Instructions")
//                .font(.system(size: Constant.MealDetail.subtitleFontSize, weight: .medium))
//            Text(manager.mealDetail?.strInstructions ?? "")
//        }
//        .padding(.horizontal)
//    }
//    
//    private var dessertImage: some View {
//        ZStack {
//            AsyncImage(url: URL(string: manager.meal.strMealThumb)) { phase in
//                if let image = phase.image {
//                    image
//                        .resizable()
//                        .scaledToFill()
//                        .clipShape(.buttonBorder)
//                } else if phase.error != nil {
//                    Image(systemName: "exclamationmark.icloud")
//                } else {
//                    ProgressView()
//                }
//            }
//            LinearGradient(gradient: Gradient(colors: [.clear, .white]), startPoint: .top, endPoint: .bottom)
//        }
//        .frame(height: Constant.MealDetail.imageHeight)
//    }
}
