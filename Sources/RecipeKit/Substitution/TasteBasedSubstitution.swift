//
//  TasteBasedSubstitution.swift
//  RecipeKit
//
//  Created by Yannis De Cleene on 30/12/2024.
//

import Foundation

class TasteBasedSubstitution: IngredientSubstitutionStrategy {
    private let availableIngredients: [Ingredient]
    
    init(availableIngredients: [Ingredient]) {
        self.availableIngredients = availableIngredients
    }
    
    func findSubstitute(for ingredient: Ingredient, in context: SubstitutionContext) -> Ingredient? {
        return findSubstitutes(for: ingredient, in: context).first?.ingredient
    }
    
    func findSubstitutes(for ingredient: Ingredient, in context: SubstitutionContext) -> [(ingredient: Ingredient, score: Double)] {
        let maxPossibleScore = calculateMaxPossibleScore(for: ingredient, in: context)
        
        return availableIngredients
            .map { candidate in
                let score = calculateTasteScore(for: ingredient, with: candidate, in: context)
                let percentageScore = Double(score) / Double(maxPossibleScore)
                return (candidate, percentageScore)
            }
            .filter { $0.score > 0 }
            .sorted { $0.score > $1.score }
    }
    
    private func calculateMaxPossibleScore(for ingredient: Ingredient, in context: SubstitutionContext) -> Int {
        var maxScore = 0
        
        // Max score for matching tastes
        maxScore += ingredient.flavorProfile.count * 20
        
        // Max score for complete taste match
        maxScore += 15
        
        // Max score for target taste
        if context.targetTaste != nil {
            maxScore += 30
        }
        
        return maxScore
    }
    
    private func calculateTasteScore(for ingredient: Ingredient, with candidate: Ingredient, in context: SubstitutionContext) -> Int {
        var score = 0
        
        // Match flavor profiles
        let matchingTastes = candidate.flavorProfile.intersection(ingredient.flavorProfile)
        score += matchingTastes.count * 20
        
        // Bonus for complete taste match
        if candidate.flavorProfile == ingredient.flavorProfile {
            score += 15
        }
        
        // Consider context's target taste with highest priority
        if let targetTaste = context.targetTaste,
           candidate.flavorProfile.contains(targetTaste) {
            score += 30
        }
        
        // Penalize if candidate has additional strong tastes not in original
        let extraTastes = candidate.flavorProfile.subtracting(ingredient.flavorProfile)
        score -= extraTastes.count * 5
        
        return score
    }
} 
