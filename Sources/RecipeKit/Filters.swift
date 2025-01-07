//
//  Filters.swift
//  RecipeKit
//
//  Created by Yannis De Cleene on 30/12/2024.
//

import Foundation

public protocol DietaryRule {
    func isSatisfied(by ingredient: Ingredient) -> Bool
}

public struct VeganRule: DietaryRule {
    public func isSatisfied(by ingredient: Ingredient) -> Bool {
        ingredient.dietaryRestrictions.contains(.vegan)
    }
}

public struct GlutenFreeRule: DietaryRule {
    public func isSatisfied(by ingredient: Ingredient) -> Bool {
        ingredient.dietaryRestrictions.contains(.glutenFree)
    }
}

public struct AllergenRule: DietaryRule {
    public let allergens: Set<Allergen>
    
    public init(allergens: Set<Allergen>) {
        self.allergens = allergens
    }
    
    public init(allergen: Allergen) {
        self.allergens = [allergen]
    }
    
    public func isSatisfied(by ingredient: Ingredient) -> Bool {
        ingredient.allergens.isDisjoint(with: allergens)
    }
}

public struct RecipeFilter {
    public let dietaryRules: [DietaryRule]
    
    public func filter(recipes: [Recipe]) -> [Recipe] {
        recipes.filter { recipe in
            recipe.ingredients.allSatisfy { ingredient in
                dietaryRules.allSatisfy { $0.isSatisfied(by: ingredient) }
            }
        }
    }
}


public protocol IngredientFilter {
    func filter(ingredients: [Ingredient]) -> [Ingredient]
}

public struct VeganFilter: IngredientFilter {
    public func filter(ingredients: [Ingredient]) -> [Ingredient] {
        ingredients.filter { $0.dietaryRestrictions.contains(.vegan) }
    }
}

public struct GlutenFreeFilter: IngredientFilter {
    public func filter(ingredients: [Ingredient]) -> [Ingredient] {
        ingredients.filter { $0.dietaryRestrictions.contains(.glutenFree) }
    }
}
