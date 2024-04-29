//
//  MealDetail.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI

struct MealDetail: View {
    @Environment(ImageCenter.self) private var imageCenter
    @Environment(FavoriteListManager.self) private var favoritesManager
    @State private var manager: MealDetailManager = MealDetailManager()
    @State private var themes: [Color] = [Color.green, Color.orange, Color.blue, Color.pink, Color.yellow, Color.purple]
    @State private var image: UIImage?
    @State private var selectedRecipeComponent: RecipeComponent = .ingredients
    @State private var isFavorite: Bool
    let meal: Meal
    
    init(meal: Meal, favorites: [Meal]) {
        self.meal = meal
        _isFavorite = .init(initialValue: favorites.contains { $0.name == meal.name })
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
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
        }
        .task {
            await manager.fetchDetail(for: meal.id)
            image = await imageCenter.getImage(from: meal.thumb)
        }
    }
    
    private var favoriteButton: some View {
        Button {
            isFavorite ? favoritesManager.delete(meal) : favoritesManager.add(meal)
            isFavorite.toggle()
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
            GeometryReader { proxy in
                ZStack {
                    ScrollView {
                        VStack(spacing: Constant.MealDetail.mainContentVStackSpacing) {
                            headingSection
                            NavigationBar(selectedComponent: $selectedRecipeComponent)
                            switch selectedRecipeComponent {
                            case .instructions:
                                instructionsSection
                            case .ingredients:
                                ingredientsSection
                            }
                        }
                    }
                    .padding(.bottom)
                    .clipShape(RoundedRectangle(cornerRadius: Constant.MealDetail.cornerRadius))
                    favoriteButton
                        .padding(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .offset(y: -proxy.frame(in: .local).height /  2)
                }
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
            HStack {
                Text("\(manager.detail.0?.ingredients.count ?? 0) Item(s)")
                    .foregroundStyle(.gray)
                Spacer()
            }
            VStack(spacing: 0) {
                ForEach(0..<(manager.detail.0?.ingredients.count ?? 0), id: \.self) { index in
                    if let ingredient = manager.detail.0?.ingredients[index], let measure = manager.detail.0?.measures[index] {
                        IngredientRow(ingredient: ingredient, measure: measure, theme: themes[index % themes.count])
                    }
                }
            }
        }
        .padding(.horizontal)
    }

    private var instructionsSection: some View {
        Text(manager.detail.0?.instructions ?? "")
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
    
