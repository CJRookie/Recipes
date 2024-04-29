//
//  Constant.swift
//  Recipes
//
//  Created by CJ on 3/5/24.
//

import Foundation

struct Constant {
    struct MealRow {
        static let shadowOpacity: CGFloat = 0.3
        static let roundedRecHeight: CGFloat = 96
        static let chevronColorOpacity: CGFloat = 0.8
        static let overlayPadding: CGFloat = 8
    }
    
    struct IngredientRow {
        static let imagePadding: CGFloat = 4
        static let rowHeight: CGFloat = 48
        static let cornerRadius: CGFloat = 8
        static let themeOpacity: CGFloat = 0.1
    }
    
    struct MealDetail {
        static let outermostVStackSpacing: CGFloat = 32
        static let cornerRadius: CGFloat = 40
        static let roundedRecOpacity: CGFloat = 0.8
        static let mainContentVStackSpacing: CGFloat = 24
        static let headingSecFontSize: CGFloat = 28
        static let headingSecTopPadding: CGFloat = 24
        static let imageHeight: CGFloat = 160
        static let favoriteButtonBGPadding: CGFloat = 4
        static let favoriteButtonSize: CGFloat = 40
    }
    
    struct NavigationBar {
        static let roundedRecCornerRadius: CGFloat = 8
        static let roundedRecFillColorOpacity: CGFloat = 0.1
        static let frameWidth: CGFloat = 108
        static let frameHeight: CGFloat = 36
        static let animationDuration: CGFloat = 0.5
        static let vPadding: CGFloat = 4
    }
    
    struct Configure {
        static let resourceFile = "URLDic"
        static let categoriesURLKey = "Categories_URL"
        static let categoryBaseURLKey = "Category_Base_URL"
        static let detailBaseURLkey = "Detail_Base_URL"
        static let ingredientImageBaseURLKey = "Ingredient_Image_Base_URL"
    }
}
