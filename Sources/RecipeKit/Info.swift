//
//  File.swift
//  RecipeKit
//
//  Created by Yannis De Cleene on 30/12/2024.
//

import Foundation

protocol IngredientInfo {
    var name: String { get }
    var dietaryRestrictions: Set<DietaryRestriction> { get }
}

protocol AllergenInfo {
    var allergens: Set<Allergen> { get }
}

protocol NutritionalInfo {
    var calories: Int { get }
    var macros: [String: Int] { get }
}
