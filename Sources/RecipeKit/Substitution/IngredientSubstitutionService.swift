//
//  IngredientSubstitutionService.swift
//  RecipeKit
//
//  Created by Yannis De Cleene on 30/12/2024.
//

import Foundation

class IngredientSubstitutionService {
    private let strategies: [IngredientSubstitutionStrategy]
    private let context: SubstitutionContext
    
    init(strategies: [IngredientSubstitutionStrategy], context: SubstitutionContext) {
        self.strategies = strategies
        self.context = context
    }
    
    func findSubstitute(for ingredient: Ingredient) -> Ingredient? {
        for strategy in strategies {
            if let substitute = strategy.findSubstitute(for: ingredient, in: context) {
                return substitute
            }
        }
        return nil
    }
}


