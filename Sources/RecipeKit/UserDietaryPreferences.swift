import Foundation

public struct UserDietaryPreferences {
    public var dietaryRestrictions: Set<DietaryRestriction>
    public var allergens: Set<Allergen>
    public var excludedIngredients: Set<String> // Store ingredient names that user wants to avoid
    
    public init(
        dietaryRestrictions: Set<DietaryRestriction> = [],
        allergens: Set<Allergen> = [],
        excludedIngredients: Set<String> = []
    ) {
        self.dietaryRestrictions = dietaryRestrictions
        self.allergens = allergens
        self.excludedIngredients = excludedIngredients
    }
    
    public func createRecipeFilter() -> RecipeFilter {
        var rules: [DietaryRule] = []
        
        // Add rules for each dietary restriction
        for restriction in dietaryRestrictions {
            rules.append(DietaryRestrictionRule(restriction: restriction))
        }
        
        // Add allergen rule if there are allergens
        if !allergens.isEmpty {
            rules.append(AllergenRule(allergens: allergens))
        }
        
        // Add excluded ingredients rule
        if !excludedIngredients.isEmpty {
            rules.append(ExcludedIngredientsRule(excludedIngredients: excludedIngredients))
        }
        
        return RecipeFilter(dietaryRules: rules)
    }
}

// Custom DietaryRule for specific dietary restrictions
public struct DietaryRestrictionRule: DietaryRule {
    public let restriction: DietaryRestriction
    
    public func isSatisfied(by ingredient: Ingredient) -> Bool {
        ingredient.dietaryRestrictions.contains(restriction)
    }
}

// Rule for excluded ingredients
public struct ExcludedIngredientsRule: DietaryRule {
    public let excludedIngredients: Set<String>
    
    public func isSatisfied(by ingredient: Ingredient) -> Bool {
        !excludedIngredients.contains(ingredient.name)
    }
}
