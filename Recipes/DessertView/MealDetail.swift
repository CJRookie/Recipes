//
//  MealDetail.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI

struct MealDetail: View {
    @Environment(MealsManager.self) private var manager
    @State private var themes: [Color] = [Color.green, Color.orange, Color.blue, Color.pink, Color.yellow, Color.purple]
    @State private var mealDetail: (Meal.Detail?, Error?)
    @State private var image: UIImage?
    @State private var meal: Meals.Meal
    @State private var isFavorite: Bool
    
    init(_ meal: Meals.Meal, _ favorites: [String]) {
        self.meal = meal
        _isFavorite = State(initialValue: favorites.contains(meal.meal))
    }

    var body: some View {
        VStack(spacing: Constant.MealDetail.outermostVStackSpacing) {
            dessertImage
            ZStack {
                RoundedRectangle(cornerRadius: Constant.MealDetail.cornerRadius)
                    .fill(.white.opacity(Constant.MealDetail.roundedRecOpacity))
                detailContent
                favoriteButton
                    .padding(.trailing)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .offset(y: Constant.MealDetail.favoriteButtonYOffset)
            }
            .scrollIndicators(.hidden)
        }
        .ignoresSafeArea(edges: .top)
        .task {
            mealDetail = await manager.fetchMealDetail(for: meal)
            image = await manager.getImage(from: meal.mealThumb)
        }
    }
    
    private var favoriteButton: some View {
        Button {
            isFavorite.toggle()
            manager.updateFavoriteRecipes(isAdded: isFavorite, with: meal.meal)
        } label: {
            Image(systemName: "heart.circle.fill")
                .background(Circle().fill(.white).padding(Constant.MealDetail.favoriteButtonBGPadding))
                .foregroundStyle(isFavorite ? .red : .gray)
                .font(.system(size: Constant.MealDetail.favoriteButtonSize))
        }
    }
    
    @ViewBuilder
    private var detailContent: some View {
        if mealDetail.0 != nil {
            ScrollView {
                VStack(spacing: Constant.MealDetail.mainContentVStackSpacing) {
                    headingSection
                    ingredientsSection
                    instructionsSection
                }
            }
            .padding(.bottom)
            .clipShape(RoundedRectangle(cornerRadius: Constant.MealDetail.cornerRadius))
        } else if mealDetail.1 == nil {
            ProgressView()
        } else {
            Text("Instructions will be added soon.")
        }
    }
    
    private var headingSection: some View {
        Text(mealDetail.0?.meal ?? "")
            .font(.system(size: Constant.MealDetail.headingSecFontSize, weight: .semibold))
            .padding(.top, Constant.MealDetail.headingSecTopPadding)
    }

    private var ingredientsSection: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {
                Text("Ingredients")
                    .font(.system(size: Constant.MealDetail.subtitleFontSize, weight: .medium))
                Spacer()
                Text("\(mealDetail.0?.strIngredients.count ?? 0) Item(s)")
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal)

            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<(mealDetail.0?.strIngredients.count ?? 0), id: \.self) { index in
                        if let ingredient = mealDetail.0?.strIngredients[index], let measure = mealDetail.0?.strMeasures[index] {
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
            Text(mealDetail.0?.instructions ?? "")
        }
        .padding(.horizontal)
    }

    private var dessertImage: some View {
        ZStack {
            Image(uiImage: image ?? UIImage())
                .resizable()
                .scaledToFill()
                .clipShape(.buttonBorder)
            LinearGradient(gradient: Gradient(colors: [.clear, .white]), startPoint: .top, endPoint: .bottom)
        }
        .frame(height: Constant.MealDetail.imageHeight)
    }
}
    
