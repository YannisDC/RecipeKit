//
//  SubstitutionContext.swift
//  RecipeKit
//
//  Created by Yannis De Cleene on 30/12/2024.
//

import Foundation

struct SubstitutionContext {
    let purpose: String  // e.g., "sweetening", "binding"
    let cookingMethod: String  // e.g., "baking", "frying"
    let targetTaste: Taste?    // The primary taste we're trying to match
    
    init(purpose: String, cookingMethod: String, targetTaste: Taste? = nil) {
        self.purpose = purpose
        self.cookingMethod = cookingMethod
        self.targetTaste = targetTaste
    }
}
