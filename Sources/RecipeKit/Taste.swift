//
//  Taste.swift
//  RecipeKit
//
//  Created by Yannis De Cleene on 30/12/2024.
//

import Foundation

@preconcurrency
public struct Taste: Hashable, Codable {
    public let name: String
}

extension Taste {
    public static let sweet = Taste(name: "sweet")
    public static let bitter = Taste(name: "bitter")
    public static let sour = Taste(name: "sour")
    public static let salty = Taste(name: "salty")
    public static let umami = Taste(name: "umami")
}

struct BaseTastes {
    static let allTastes = [
        Taste.sweet,
        Taste.bitter,
        Taste.sour,
        Taste.salty,
        Taste.umami
    ]
}
