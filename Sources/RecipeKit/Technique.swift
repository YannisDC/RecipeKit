//
//  Technique.swift
//  RecipeKit
//
//  Created by Yannis De Cleene on 30/12/2024.
//

import Foundation

// Implementing it like this instead of an enum so we can extend it

@preconcurrency
public struct Technique: Hashable, Codable {
    public let name: String
}

extension Technique {
    static let bake = Technique(name: "bake")
    static let blanch = Technique(name: "blanch")
    static let bloom = Technique(name: "bloom")
    static let boil = Technique(name: "boil")
    static let braise = Technique(name: "braise")
    static let brine = Technique(name: "brine")
    static let broil = Technique(name: "broil")
    static let char = Technique(name: "char")
    static let deepFry = Technique(name: "deep fry")
    static let deglaze = Technique(name: "deglaze")
    static let glutenWindowTest = Technique(name: "gluten window test")
    static let knead = Technique(name: "knead")
    static let marinate = Technique(name: "marinate")
    static let microwave = Technique(name: "microwave")
    static let pickle = Technique(name: "pickle")
    static let poach = Technique(name: "poach")
    static let reduce = Technique(name: "reduce")
    static let roast = Technique(name: "roast")
    static let saute = Technique(name: "saute")
    static let sear = Technique(name: "sear")
    static let shallowFry = Technique(name: "shallow fry")
    static let simmer = Technique(name: "simmer")
    static let smoke = Technique(name: "smoke")
    static let starchSlurry = Technique(name: "starch slurry")
    static let steam = Technique(name: "steam")
    static let stirFry = Technique(name: "stir fry")
    static let velvet = Technique(name: "velvet")
}


extension Technique {
    static let confit = Technique(name: "confit")
}
