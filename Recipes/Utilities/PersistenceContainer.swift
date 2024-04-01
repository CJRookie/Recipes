//
//  PersistenceContainer.swift
//  Recipes
//
//  Created by CJ on 4/1/24.
//

import Foundation
import SwiftData

struct PersistenceContainer {
    private let container: ModelContainer
    private(set) var context: ModelContext
    
    init() {
        do {
            try container = ModelContainer(for: Meal.self)
            context = ModelContext(container)
        } catch {
            fatalError("Failed to load persistent stores: \(error)")
        }
    }
    
    init(container: ModelContainer) {
        self.container = container
        self.context = ModelContext(container)
    }
}
