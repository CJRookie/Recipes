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
    private let persistenceContainer: PersistenceContainer
    private let persistenceProvider: DataPersistenceService
    private(set) var error: Error?
    
    init() {
        persistenceContainer = PersistenceContainer()
        persistenceProvider = PersistenceProvider(context: persistenceContainer.context)
    }
    
    init(container: ModelContainer) {
        persistenceContainer = PersistenceContainer(container: container)
        persistenceProvider = PersistenceProvider(context: persistenceContainer.context)
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
        }
        fetchFavoriteRecipes()
    }
}
