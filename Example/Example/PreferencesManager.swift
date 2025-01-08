import Foundation
import SwiftUI
import RecipeKit

class PreferencesManager: ObservableObject {
    static let shared = PreferencesManager()
    
    @Published private(set) var preferences: UserDietaryPreferences
    
    @AppStorage("dietaryRestrictionsData") private var dietaryRestrictionsData: Data = Data()
    @AppStorage("allergensData") private var allergensData: Data = Data()
    @AppStorage("excludedIngredients") private var excludedIngredientsString: String = ""
    
    private init() {
        // Initialize with empty preferences first
        self.preferences = UserDietaryPreferences()
        
        // Then load saved preferences
        loadSavedPreferences()
    }
    
    private func loadSavedPreferences() {
        self.preferences = Self.loadPreferences(
            dietaryRestrictionsData: dietaryRestrictionsData,
            allergensData: allergensData,
            excludedIngredientsString: excludedIngredientsString
        )
    }
    
    func updatePreferences(_ newPreferences: UserDietaryPreferences) {
        preferences = newPreferences
        save()
    }
    
    private func save() {
        // Save dietary restrictions
        if let encoded = try? JSONEncoder().encode(preferences.dietaryRestrictions) {
            dietaryRestrictionsData = encoded
        }
        
        // Save allergens
        if let encoded = try? JSONEncoder().encode(preferences.allergens) {
            allergensData = encoded
        }
        
        // Save excluded ingredients
        excludedIngredientsString = preferences.excludedIngredients.joined(separator: ",")
    }
    
    private static func loadPreferences(
        dietaryRestrictionsData: Data,
        allergensData: Data,
        excludedIngredientsString: String
    ) -> UserDietaryPreferences {
        let dietaryRestrictions: Set<DietaryRestriction> = {
            if let decoded = try? JSONDecoder().decode(Set<DietaryRestriction>.self, from: dietaryRestrictionsData) {
                return decoded
            }
            return []
        }()
        
        let allergens: Set<Allergen> = {
            if let decoded = try? JSONDecoder().decode(Set<Allergen>.self, from: allergensData) {
                return decoded
            }
            return []
        }()
        
        let excludedIngredients: Set<String> = {
            if excludedIngredientsString.isEmpty {
                return []
            }
            return Set(excludedIngredientsString.split(separator: ",").map(String.init))
        }()
        
        return UserDietaryPreferences(
            dietaryRestrictions: dietaryRestrictions,
            allergens: allergens,
            excludedIngredients: excludedIngredients
        )
    }
} 
