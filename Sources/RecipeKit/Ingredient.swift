//
//  Ingredient.swift
//  RecipeKit
//
//  Created by Yannis De Cleene on 30/12/2024.
//

import Foundation

public struct Ingredient: Hashable, Codable, @unchecked Sendable {
    public let name: String
    public let dietaryRestrictions: Set<DietaryRestriction>
    public let allergens: Set<Allergen>
    public let flavorProfile: Set<Taste>
//    let agent: Set<Agent> ferments, binds
    
    public init(name: String, dietaryRestrictions: Set<DietaryRestriction>, allergens: Set<Allergen>, flavorProfile: Set<Taste>) {
        self.name = name
        self.dietaryRestrictions = dietaryRestrictions
        self.allergens = allergens
        self.flavorProfile = flavorProfile
    }
}

public struct BaseIngredients {
    public static let onion = Ingredient(
        name: "Onion",
        dietaryRestrictions: [.vegan, .vegetarian, .glutenFree, .lowFODMAP],
        allergens: [],
        flavorProfile: []
    )

    public static let butter = Ingredient(
        name: "Butter",
        dietaryRestrictions: [.vegetarian],
        allergens: [.dairy],
        flavorProfile: []
    )

    public static let almond = Ingredient(
        name: "Almond",
        dietaryRestrictions: [.vegan, .vegetarian, .glutenFree, .keto],
        allergens: [.nuts],
        flavorProfile: []
    )

    public static let all: [Ingredient] = [onion, butter, almond]
}
