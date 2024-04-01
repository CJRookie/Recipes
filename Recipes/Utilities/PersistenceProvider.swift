//
//  LocalDataRetriever.swift
//  Recipes
//
//  Created by CJ on 3/29/24.
//

import Foundation
import SwiftData

protocol DataPersistenceService {
    var context: ModelContext { get }
    func fetch() throws -> [Meal]
    func add(_ item: Meal)
    func delete(_ item: Meal)
}

struct PersistenceProvider: DataPersistenceService {
    let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetch() throws -> [Meal] {
        let descriptor = FetchDescriptor<Meal>(sortBy: [SortDescriptor(\.dateOfCreation)])
        return try context.fetch(descriptor)
    }
    
    func add(_ meal: Meal) {
        context.insert(Meal(name: meal.name, thumb: meal.thumb, id: meal.id, dateOfCreation: .now))
    }
    
    func delete(_ meal: Meal) {
        context.delete(meal)
    }
}
