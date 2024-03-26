//
//  Meals.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import Foundation
import SwiftData

struct Meals: Codable {
    let meals: [Meal]
}

@Model
class Meal: Codable, Identifiable, Hashable {
    var name: String
    var thumb: String
    @Attribute(.unique) var id: String
    var isFavorite: Bool = false
    var dateOfCreation: Date = Date.now
    var isAdded: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumb = "strMealThumb"
        case id = "idMeal"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.thumb = try container.decode(String.self, forKey: .thumb)
        self.id = try container.decode(String.self, forKey: .id)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(thumb, forKey: .thumb)
        try container.encode(id, forKey: .id)
    }
    
    init(name: String, thumb: String, id: String, isFavorite: Bool = false, dateOfCreation: Date = .now, isAdded: Bool = false) {
        self.name = name
        self.thumb = thumb
        self.id = id
        self.isFavorite = isFavorite
        self.dateOfCreation = dateOfCreation
        self.isAdded = isAdded
    }
}
