//
//  MealDetail.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI

struct MealDetail: View {
    @Environment(ImageCacheCenter.self) private var imageCache
    @State private var manager: MealDetailManager = MealDetailManager()
    @State private var themes: [Color] = [Color.green, Color.orange, Color.blue, Color.pink, Color.yellow, Color.purple]
    let meal: Meal
    @State private var image: UIImage?
    @State private var isFavorite: Bool = false
    
    init(meal: Meal) {
        self.meal = meal
//        _isFavorite = State(initialValue: manager.favoriteRecipes.contains(meal.name))
    }

    var body: some View {
        VStack(spacing: Constant.MealDetail.outermostVStackSpacing) {
            dessertImage
            ZStack {
                RoundedRectangle(cornerRadius: Constant.MealDetail.cornerRadius)
                    .fill(.white.opacity(Constant.MealDetail.roundedRecOpacity))
                detailContent
            }
            .scrollIndicators(.hidden)
        }
        .ignoresSafeArea(edges: .top)
        .task {
            await manager.fetchMealDetail(for: meal)
            if let url = URL(string: meal.thumb) {
                image = await imageCache.getRecipeImage(from: url)
            }
        }
    }
    
    private var favoriteButton: some View {
        Button {
            isFavorite.toggle()
//            manager.updateFavoriteRecipes(isAdded: isFavorite, with: meal.name)
        } label: {
            Image(systemName: "heart.circle.fill")
                .background(Circle().fill(.white).padding(Constant.MealDetail.favoriteButtonBGPadding))
                .foregroundStyle(isFavorite ? .red : .gray)
                .font(.system(size: Constant.MealDetail.favoriteButtonSize))
        }
    }
    
    @ViewBuilder
    private var detailContent: some View {
        if manager.detail.0 != nil {
            ZStack {
                ScrollView {
                    VStack(spacing: Constant.MealDetail.mainContentVStackSpacing) {
                        headingSection
                        ingredientsSection
                        instructionsSection
                    }
                }
                .padding(.bottom)
                .clipShape(RoundedRectangle(cornerRadius: Constant.MealDetail.cornerRadius))
                favoriteButton
                    .padding(.trailing)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .offset(y: Constant.MealDetail.favoriteButtonYOffset)
            }
        } else if manager.detail.1 == nil {
            ProgressView()
        } else {
            Text("Instructions will be added soon.")
        }
    }
    
    private var headingSection: some View {
        Text(manager.detail.0?.meal ?? "")
            .font(.system(size: Constant.MealDetail.headingSecFontSize, weight: .semibold))
            .padding(.top, Constant.MealDetail.headingSecTopPadding)
    }

    private var ingredientsSection: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {
                Text("Ingredients")
                    .font(.system(size: Constant.MealDetail.subtitleFontSize, weight: .medium))
                Spacer()
                Text("\(manager.detail.0?.strIngredients.count ?? 0) Item(s)")
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal)

            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<(manager.detail.0?.strIngredients.count ?? 0), id: \.self) { index in
                        if let ingredient = manager.detail.0?.strIngredients[index], let measure = manager.detail.0?.strMeasures[index] {
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
            Text(manager.detail.0?.instructions ?? "")
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
    
