//
//  MealList.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI

struct MealList: View {
    @State private var manager = MealListManager()
    let category: String
    
    var body: some View {
        ListTemplate(list: manager.mealList, navTitle: category)
            .task {
                await manager.fetchMeals(in: category)
            }
    }
}
