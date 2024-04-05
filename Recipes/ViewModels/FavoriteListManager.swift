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
    private let persistenceProvider: DataPersistenceService
    private(set) var recipes: [Meal] = []
    private(set) var error: Error?
    
    init() {
        persistenceProvider = PersistenceProvider()
    }
    
    init(container: ModelContainer) {
        persistenceProvider = PersistenceProvider(container: container)
    }
    
    func fetchFavoriteRecipes() {
        do {
            recipes = try persistenceProvider.fetch()
        } catch {
            self.error = error
        }
    }
    
    func add(_ meal: Meal) {
        persistenceProvider.add(meal)
        fetchFavoriteRecipes()
    }
    
    func delete(_ meal: Meal) {
        if let meal = recipes.first(where: { $0.name == meal.name }) {
            persistenceProvider.delete(meal)
            fetchFavoriteRecipes()
        }
    }
}
