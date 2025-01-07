//
//  RecipeService.swift
//  RecipeKit
//
//  Created by Yannis De Cleene on 30/12/2024.
//

import Foundation

struct RecipeService {
    private let filter: RecipeFilter
    
    init(filter: RecipeFilter) {
        self.filter = filter
    }
    
    func getFilteredRecipes(from recipes: [Recipe]) -> [Recipe] {
        filter.filter(recipes: recipes)
    }
}
