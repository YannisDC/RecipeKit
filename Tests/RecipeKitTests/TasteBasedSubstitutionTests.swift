import Testing
@testable import RecipeKit

@Test func testBasicTasteSubstitution() async throws {
    // Arrange
    let sugar = Ingredient(
        name: "Sugar",
        dietaryRestrictions: [.vegan, .glutenFree],
        allergens: [],
        flavorProfile: [.sweet]
    )
    
    let honey = Ingredient(
        name: "Honey",
        dietaryRestrictions: [.glutenFree],
        allergens: [],
        flavorProfile: [.sweet]
    )
    
    let lemon = Ingredient(
        name: "Lemon",
        dietaryRestrictions: [.vegan, .glutenFree],
        allergens: [],
        flavorProfile: [.sour]
    )
    
    let strategy = TasteBasedSubstitution(availableIngredients: [honey, lemon])
    
    // Act
    let substitute = strategy.findSubstitute(
        for: sugar,
        in: SubstitutionContext(purpose: "sweetening", cookingMethod: "baking", targetTaste: .sweet)
    )
    
    // Assert
    #expect(substitute != nil)
    #expect(substitute?.name == "Honey")
}

@Test func testComplexTasteSubstitution() async throws {
    // Arrange
    let soySauce = Ingredient(
        name: "Soy Sauce",
        dietaryRestrictions: [.vegan],
        allergens: [.soy],
        flavorProfile: [.salty, .umami]
    )
    
    let coconutAminos = Ingredient(
        name: "Coconut Aminos",
        dietaryRestrictions: [.vegan, .glutenFree, .soyFree],
        allergens: [],
        flavorProfile: [.salty, .umami, .sweet]
    )
    
    let fishSauce = Ingredient(
        name: "Fish Sauce",
        dietaryRestrictions: [],
        allergens: [.fish],
        flavorProfile: [.salty, .umami]
    )
    
    let strategy = TasteBasedSubstitution(availableIngredients: [coconutAminos, fishSauce])
    
    // Act
    let substitute = strategy.findSubstitute(
        for: soySauce,
        in: SubstitutionContext(purpose: "seasoning", cookingMethod: "stirFry", targetTaste: .umami)
    )
    
    // Assert
    #expect(substitute != nil)
    #expect(substitute?.name == "Fish Sauce") // Should prefer exact taste match over one with extra taste
}

@Test func testTargetTastePrioritization() async throws {
    // Arrange
    let vinegar = Ingredient(
        name: "Rice Vinegar",
        dietaryRestrictions: [.vegan, .glutenFree],
        allergens: [],
        flavorProfile: [.sour, .umami]
    )
    
    let options = [
        Ingredient(
            name: "Citrus",
            dietaryRestrictions: [.vegan, .glutenFree],
            allergens: [],
            flavorProfile: [.sour, .sweet]
        ),
        Ingredient(
            name: "Miso",
            dietaryRestrictions: [.vegan],
            allergens: [.soy],
            flavorProfile: [.umami, .salty]
        )
    ]
    
    let strategy = TasteBasedSubstitution(availableIngredients: options)
    
    // Act
    let sourSubstitute = strategy.findSubstitute(
        for: vinegar,
        in: SubstitutionContext(purpose: "acidic", cookingMethod: "dressing", targetTaste: .sour)
    )
    
    let umamiSubstitute = strategy.findSubstitute(
        for: vinegar,
        in: SubstitutionContext(purpose: "seasoning", cookingMethod: "sauce", targetTaste: .umami)
    )
    
    // Assert
    #expect(sourSubstitute?.name == "Citrus")
    #expect(umamiSubstitute?.name == "Miso")
}

@Test func testPenaltyForExtraTastes() async throws {
    // Arrange
    let salt = Ingredient(
        name: "Salt",
        dietaryRestrictions: [.vegan, .glutenFree],
        allergens: [],
        flavorProfile: [.salty]
    )
    
    let options = [
        Ingredient(
            name: "Sea Salt",
            dietaryRestrictions: [.vegan, .glutenFree],
            allergens: [],
            flavorProfile: [.salty]
        ),
        Ingredient(
            name: "Soy Sauce",
            dietaryRestrictions: [.vegan],
            allergens: [.soy],
            flavorProfile: [.salty, .umami]
        )
    ]
    
    let strategy = TasteBasedSubstitution(availableIngredients: options)
    
    // Act
    let substitute = strategy.findSubstitute(
        for: salt,
        in: SubstitutionContext(purpose: "seasoning", cookingMethod: "finishing", targetTaste: .salty)
    )
    
    // Assert
    #expect(substitute?.name == "Sea Salt") // Should prefer exact match without extra tastes
}

@Test func testSubstitutesWithScores() async throws {
    // Arrange
    let soySauce = Ingredient(
        name: "Soy Sauce",
        dietaryRestrictions: [.vegan],
        allergens: [.soy],
        flavorProfile: [.salty, .umami]
    )
    
    let substitutes = [
        Ingredient(
            name: "Fish Sauce",
            dietaryRestrictions: [],
            allergens: [.fish],
            flavorProfile: [.salty, .umami]
        ),
        Ingredient(
            name: "Coconut Aminos",
            dietaryRestrictions: [.vegan, .glutenFree],
            allergens: [],
            flavorProfile: [.salty, .umami, .sweet]
        ),
        Ingredient(
            name: "Salt",
            dietaryRestrictions: [.vegan, .glutenFree],
            allergens: [],
            flavorProfile: [.salty]
        )
    ]
    
    let strategy = TasteBasedSubstitution(availableIngredients: substitutes)
    
    // Act
    let results = strategy.findSubstitutes(
        for: soySauce,
        in: SubstitutionContext(purpose: "seasoning", cookingMethod: "stirFry", targetTaste: .umami)
    )
    
    // Assert
    #expect(results.count == 3)
    #expect(results[0].ingredient.name == "Fish Sauce")
    #expect(results[0].score > 0.9) // Should be close to 1.0 for perfect match
    #expect(results[1].ingredient.name == "Coconut Aminos")
    #expect(results[1].score < results[0].score) // Should be lower due to extra taste
    #expect(results[2].ingredient.name == "Salt")
    #expect(results[2].score < results[1].score) // Should be lowest due to missing umami
}

@Test func testSubstitutesWithTargetTaste() async throws {
    // Arrange
    let vinegar = Ingredient(
        name: "Rice Vinegar",
        dietaryRestrictions: [.vegan],
        allergens: [],
        flavorProfile: [.sour]
    )
    
    let substitutes = [
        Ingredient(
            name: "Lemon Juice",
            dietaryRestrictions: [.vegan],
            allergens: [],
            flavorProfile: [.sour]
        ),
        Ingredient(
            name: "Apple Cider Vinegar",
            dietaryRestrictions: [.vegan],
            allergens: [],
            flavorProfile: [.sour, .sweet]
        )
    ]
    
    let strategy = TasteBasedSubstitution(availableIngredients: substitutes)
    
    // Act
    let resultsForSour = strategy.findSubstitutes(
        for: vinegar,
        in: SubstitutionContext(purpose: "acidic", cookingMethod: "dressing", targetTaste: .sour)
    )
    
    let resultsForSweet = strategy.findSubstitutes(
        for: vinegar,
        in: SubstitutionContext(purpose: "acidic", cookingMethod: "dressing", targetTaste: .sweet)
    )
    
    // Assert
    #expect(resultsForSour[0].ingredient.name == "Lemon Juice")
    #expect(resultsForSour[0].score == 1.0)
    
    #expect(resultsForSweet[0].ingredient.name == "Apple Cider Vinegar")
    #expect(resultsForSweet[0].score > resultsForSweet[1].score)
} 