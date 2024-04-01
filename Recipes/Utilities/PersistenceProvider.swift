//
//  PersistenceProvider.swift
//  Recipes
//
//  Created by CJ on 3/29/24.
//

import Foundation
import SwiftData

protocol DataPersistenceService {
    associatedtype Item: PersistentModel
    var context: ModelContext { get }
    func fetch() throws -> [Item]
    func add(_ item: Item)
    func delete(_ item: Item)
}

struct PersistenceProvider: DataPersistenceService {
    typealias Item = Meal
    var context: ModelContext
    
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

//struct PersistenceProvider<T>: DataPersistenceService where T: PersistentModel {
//    private let container: ModelContainer
//    var context: ModelContext
//    
//    init() {
//        do {
//            container = try ModelContainer(for: T.self)
//            context = ModelContext(container)
//        } catch {
//            fatalError("unable to create container for the model 'Meal'.")
//        }
//    }
//    
//    init(container: ModelContainer) {
//        self.container = container
//        context = ModelContext(container)
//    }
//    
//    func fetch(_ descriptor: FetchDescriptor<T>) throws -> [T] where T : PersistentModel {
//        return try context.fetch(descriptor)
//    }
//    
//    func add(_ item: T) where T : PersistentModel {
//        context.insert(item)
//    }
//    
//    func delete(_ item: T) where T : PersistentModel {
//        context.delete(item)
//    }
//}
