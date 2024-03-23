//
//  Categories.swift
//  Recipes
//
//  Created by CJ on 3/17/24.
//

import Foundation

struct Categories: Codable, Equatable {
    let categories: [Category]
}

struct Category: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let thumb: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case thumb = "strCategoryThumb"
    }
}
