//
//  DietaryRestriction.swift
//  RecipeKit
//
//  Created by Yannis De Cleene on 30/12/2024.
//

import Foundation

// Implementing it like this instead of an enum so we can extend it
public struct DietaryRestriction: Hashable, Codable, @unchecked Sendable {
    public let name: String

    public init(name: String) {
        self.name = name
    }
}

extension DietaryRestriction {
    public static let vegan = DietaryRestriction(name: "vegan")
    public static let vegetarian = DietaryRestriction(name: "vegetarian")
    public static let glutenFree = DietaryRestriction(name: "glutenFree")
    public static let keto = DietaryRestriction(name: "keto")
    public static let lowFODMAP = DietaryRestriction(name: "lowFODMAP")
    public static let dairyFree = DietaryRestriction(name: "dairyFree")
    public static let nutFree = DietaryRestriction(name: "nutFree")
    public static let pescatarian = DietaryRestriction(name: "pescatarian")
    
    // Added common dietary restrictions
    public static let halal = DietaryRestriction(name: "halal")
    public static let kosher = DietaryRestriction(name: "kosher")
    public static let eggFree = DietaryRestriction(name: "eggFree")
    public static let soyFree = DietaryRestriction(name: "soyFree")
    public static let shellfish = DietaryRestriction(name: "shellfish")
    public static let paleo = DietaryRestriction(name: "paleo")
    public static let whole30 = DietaryRestriction(name: "whole30")
    public static let diabetic = DietaryRestriction(name: "diabetic")
    public static let lowSodium = DietaryRestriction(name: "lowSodium")
    public static let lowCalorie = DietaryRestriction(name: "lowCalorie")
}

public struct BaseDietaryRestrictions {
    public static let all: [DietaryRestriction] = [
        DietaryRestriction.vegan,
        DietaryRestriction.vegetarian,
        DietaryRestriction.glutenFree,
        DietaryRestriction.keto,
        DietaryRestriction.lowFODMAP,
        DietaryRestriction.dairyFree,
        DietaryRestriction.nutFree,
        DietaryRestriction.pescatarian,
        DietaryRestriction.halal,
        DietaryRestriction.kosher,
        DietaryRestriction.eggFree,
        DietaryRestriction.soyFree,
        DietaryRestriction.shellfish,
        DietaryRestriction.paleo,
        DietaryRestriction.whole30,
        DietaryRestriction.diabetic,
        DietaryRestriction.lowSodium,
        DietaryRestriction.lowCalorie
    ]
}
