import Testing
@testable import RecipeKit

@Test func testFindSubstituteWithScoredStrategy() async throws {
    // Arrange
    let butter = Ingredient(
        name: "Butter",
        dietaryRestrictions: [.vegetarian],
        allergens: [.dairy],
        flavorProfile: []
    )
    
    let coconutOil = Ingredient(
        name: "Coconut Oil",
        dietaryRestrictions: [.vegan, .vegetarian],
        allergens: [],
        flavorProfile: []
    )
    
    let context = SubstitutionContext(
        purpose: "frying",
        cookingMethod: "saute"
    )
    
    let strategy = ScoredSubstitution(availableIngredients: [coconutOil])
    let service = IngredientSubstitutionService(
        strategies: [strategy],
        context: context
    )
    
    // Act
    let substitute = service.findSubstitute(for: butter)
    
    // Assert
    #expect(substitute != nil)
    #expect(substitute?.name == "Coconut Oil")
}

@Test func testNoSubstituteFoundWhenNoMatchingIngredients() async throws {
    // Arrange
    let butter = Ingredient(
        name: "Butter",
        dietaryRestrictions: [.vegetarian],
        allergens: [.dairy],
        flavorProfile: []
    )
    
    let cream = Ingredient(
        name: "Cream",
        dietaryRestrictions: [.vegetarian],
        allergens: [.dairy],
        flavorProfile: [.salty]
    )
    
    let context = SubstitutionContext(
        purpose: "frying",
        cookingMethod: "saute"
    )
    
    // Create a failing strategy that will return nil
    struct FailingStrategy: IngredientSubstitutionStrategy {
        func findSubstitute(for ingredient: Ingredient, in context: SubstitutionContext) -> Ingredient? {
            return nil
        }
    }
    
    let strategy = FailingStrategy()
    let service = IngredientSubstitutionService(
        strategies: [strategy],
        context: context
    )
    
    // Act
    let substitute = service.findSubstitute(for: butter)
    
    // Assert
    #expect(substitute == nil)
}

@Test func testMultipleStrategiesAreTriedInOrder() async throws {
    // Arrange
    let butter = Ingredient(
        name: "Butter",
        dietaryRestrictions: [.vegetarian],
        allergens: [.dairy],
        flavorProfile: []
    )
    
    let coconutOil = Ingredient(
        name: "Coconut Oil",
        dietaryRestrictions: [.vegan, .vegetarian],
        allergens: [],
        flavorProfile: []
    )
    
    let context = SubstitutionContext(
        purpose: "frying",
        cookingMethod: "saute"
    )
    
    // Create a failing strategy that will return nil
    struct FailingStrategy: IngredientSubstitutionStrategy {
        func findSubstitute(for ingredient: Ingredient, in context: SubstitutionContext) -> Ingredient? {
            return nil
        }
    }
    
    let strategies: [IngredientSubstitutionStrategy] = [
        FailingStrategy(),
        ScoredSubstitution(availableIngredients: [coconutOil])
    ]
    
    let service = IngredientSubstitutionService(
        strategies: strategies,
        context: context
    )
    
    // Act
    let substitute = service.findSubstitute(for: butter)
    
    // Assert
    #expect(substitute != nil)
    #expect(substitute?.name == "Coconut Oil")
}

@Test func testSubstitutionWithDietaryRestrictions() async throws {
    // Arrange
    let butter = Ingredient(
        name: "Butter",
        dietaryRestrictions: [.vegetarian],
        allergens: [.dairy],
        flavorProfile: []
    )
    
    let coconutOil = Ingredient(
        name: "Coconut Oil",
        dietaryRestrictions: [.vegan, .vegetarian],
        allergens: [],
        flavorProfile: []
    )
    
    let cream = Ingredient(
        name: "Cream",
        dietaryRestrictions: [.vegetarian],
        allergens: [.dairy],
        flavorProfile: []
    )
    
    let context = SubstitutionContext(
        purpose: "frying",
        cookingMethod: "saute"
    )
    
    let strategy = ScoredSubstitution(availableIngredients: [coconutOil, cream])
    let service = IngredientSubstitutionService(
        strategies: [strategy],
        context: context
    )
    
    // Act
    let substitute = service.findSubstitute(for: butter)
    
    // Assert
    #expect(substitute != nil)
    #expect(substitute?.name == "Coconut Oil")
    #expect(substitute?.dietaryRestrictions.contains(.vegan) ?? false)
}
