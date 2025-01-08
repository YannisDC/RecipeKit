//
//  Allergen.swift
//  RecipeKit
//
//  Created by Yannis De Cleene on 30/12/2024.
//

import Foundation

// Implementing it like this instead of an enum so we can extend it
public struct Allergen: Hashable, Codable, @unchecked Sendable {
    public let name: String

    public init(name: String) {
        self.name = name
    }
}

extension Allergen {
    public static let gluten = Allergen(name: "Gluten")
    public static let shellfish = Allergen(name: "Shellfish")
    public static let eggs = Allergen(name: "Eggs")
    public static let fish = Allergen(name: "Fish")
    public static let peanuts = Allergen(name: "Peanuts")
    public static let soy = Allergen(name: "Soy")
    public static let dairy = Allergen(name: "Dairy")
    public static let nuts = Allergen(name: "Nuts")
    public static let celery = Allergen(name: "Celery")
    public static let mustard = Allergen(name: "Mustard")
    public static let sesame = Allergen(name: "Sesame")
    public static let sulphites = Allergen(name: "Sulphites")
    public static let lupin = Allergen(name: "Lupin")
    public static let molluscs = Allergen(name: "Molluscs")
}

public struct BaseAllergens {
    public static let all: [Allergen] = [
        Allergen.gluten,
        Allergen.shellfish,
        Allergen.eggs,
        Allergen.fish,
        Allergen.peanuts,
        Allergen.soy,
        Allergen.dairy,
        Allergen.nuts,
        Allergen.celery,
        Allergen.mustard,
        Allergen.sesame,
        Allergen.sulphites,
        Allergen.lupin,
        Allergen.molluscs
    ]
}

