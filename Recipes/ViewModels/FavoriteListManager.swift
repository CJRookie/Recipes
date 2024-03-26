//
//  FavoriteListManager.swift
//  Recipes
//
//  Created by CJ on 3/26/24.
//

import Foundation
import SwiftData

@Observable
class FavoriteListManager {
    private(set) var recipes: [Meal] = []
    private let context: ModelContext
    
    init(context: ModelContext = LocalDataCenter.shared.context) {
        self.context = context
    }
    
    func getFavoriteRecipes() {
        do {
            let descriptor = FetchDescriptor<Meal>(sortBy: [SortDescriptor(\.dateOfCreation)])
            recipes = try context.fetch(descriptor)
        } catch {
            print("Unable to get the favorite recipes: \(error)")
        }
    }
    
    func add(_ meal: Meal) {
        context.insert(Meal(name: meal.name, thumb: meal.thumb, id: meal.id, dateOfCreation: .now))
        getFavoriteRecipes()
    }
    
    func delete(_ meal: Meal) {
        if let meal = recipes.first(where: { $0.name == meal.name }) {
            context.delete(meal)
        }
        getFavoriteRecipes()
    }
}

class LocalDataCenter {
    static let shared = LocalDataCenter()
    private let container: ModelContainer
    let context: ModelContext
    
    private init() {
        do {
            container = try ModelContainer(for: Meal.self)
            context = ModelContext(container)
        } catch {
            fatalError("Failed to create container for 'Meal'.")
        }
    }
}
