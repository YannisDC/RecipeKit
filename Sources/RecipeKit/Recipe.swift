//
//  Recipe.swift
//  RecipeKit
//
//  Created by Yannis De Cleene on 30/12/2024.
//

import Foundation

public struct Recipe: Identifiable, Codable {
    public let id: UUID
    public let name: String
    public let description: String
    public let ingredients: [Ingredient]
    public let instructions: [String]
    public let techniques: [Technique]
    public let tastes: [Taste]
    
    public init(
        id: UUID = UUID(),
        name: String,
        description: String,
        ingredients: [Ingredient],
        instructions: [String],
        techniques: [Technique] = [],
        tastes: [Taste] = []
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.ingredients = ingredients
        self.instructions = instructions
        self.techniques = techniques
        self.tastes = tastes
    }
}
