//
//  IngredientSubstitution.swift
//  RecipeKit
//
//  Created by Yannis De Cleene on 30/12/2024.
//

import Foundation

protocol IngredientSubstitutionStrategy {
    func findSubstitute(for ingredient: Ingredient, in context: SubstitutionContext) -> Ingredient?
    func findSubstitutes(for ingredient: Ingredient, in context: SubstitutionContext) -> [(ingredient: Ingredient, score: Double)]
}

// Add default implementation for backward compatibility
extension IngredientSubstitutionStrategy {
    func findSubstitutes(for ingredient: Ingredient, in context: SubstitutionContext) -> [(ingredient: Ingredient, score: Double)] {
        if let substitute = findSubstitute(for: ingredient, in: context) {
            return [(substitute, 1.0)]
        }
        return []
    }
}

class DietaryRestrictionSubstitution: IngredientSubstitutionStrategy {
    private let availableIngredients: [Ingredient]
    
    init(availableIngredients: [Ingredient]) {
        self.availableIngredients = availableIngredients
    }
    
    func findSubstitute(for ingredient: Ingredient, in context: SubstitutionContext) -> Ingredient? {
        return availableIngredients.first { candidate in
            candidate.dietaryRestrictions.isSuperset(of: ingredient.dietaryRestrictions) &&
            candidate.allergens.isDisjoint(with: ingredient.allergens)
        }
    }
}

class AllergenFreeSubstitution: IngredientSubstitutionStrategy {
    private let availableIngredients: [Ingredient]
    
    init(availableIngredients: [Ingredient]) {
        self.availableIngredients = availableIngredients
    }
    
    func findSubstitute(for ingredient: Ingredient, in context: SubstitutionContext) -> Ingredient? {
        return availableIngredients.first { candidate in
            candidate.allergens.isDisjoint(with: ingredient.allergens)
        }
    }
}

class ScoredSubstitution: IngredientSubstitutionStrategy {
    private let availableIngredients: [Ingredient]
    
    init(availableIngredients: [Ingredient]) {
        self.availableIngredients = availableIngredients
    }
    
    func findSubstitute(for ingredient: Ingredient, in context: SubstitutionContext) -> Ingredient? {
        return availableIngredients
            .map { candidate in
                let score = calculateScore(for: ingredient, with: candidate, in: context)
                return (candidate, score)
            }
            .filter { $0.1 > 0 }  // Only consider positive scores
            .max { $0.1 < $1.1 }?.0  // Return the highest-scoring substitute
    }
    
    private func calculateScore(for ingredient: Ingredient, with candidate: Ingredient, in context: SubstitutionContext) -> Int {
        var score = 0
        
        // Match dietaryRestrictions
        score += candidate.dietaryRestrictions.intersection(ingredient.dietaryRestrictions).count * 10
        
        // Avoid allergens
        if candidate.allergens.isDisjoint(with: ingredient.allergens) {
            score += 20
        }
        
        // Match flavor profiles
        let matchingTastes = candidate.flavorProfile.intersection(ingredient.flavorProfile)
        score += matchingTastes.count * 15
        
        // Bonus for complete taste match
        if candidate.flavorProfile == ingredient.flavorProfile {
            score += 10
        }
        
        // Consider context purpose for taste
        if let targetTaste = context.targetTaste,
           candidate.flavorProfile.contains(targetTaste) {
            score += 25
        }
        
        return score
    }
}
