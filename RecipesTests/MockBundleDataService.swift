//
//  MockBundleDataService.swift
//  RecipesTests
//
//  Created by CJ on 4/5/24.
//

import Foundation
@testable import Recipes

struct MockBundleDataService: BundleDataService {
    func retrieveDownloadURL(from resourceFile: String, basedOn key: String) throws -> String {
        return "mockURL"
    }
}
