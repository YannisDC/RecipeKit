import Testing
@testable import RecipeKit

@Test func testRecipeFilterWithAllergenRule() async throws {
    // Arrange
    let allergenFreeIngredient = Ingredient(
        name: "Rice",
        dietaryRestrictions: [.vegan, .glutenFree],
        allergens: [],
        flavorProfile: []
    )
    
    let dairyIngredient = Ingredient(
        name: "Cream",
        dietaryRestrictions: [.vegetarian],
        allergens: [.dairy],
        flavorProfile: []
    )
    
    let allergenFreeRecipe = Recipe(
        name: "Plain Rice",
        description: "",
        ingredients: [allergenFreeIngredient],
        instructions: ["Cook rice"]
    )
    
    let dairyRecipe = Recipe(
        name: "Creamy Rice",
        description: "",
        ingredients: [allergenFreeIngredient, dairyIngredient],
        instructions: ["Cook rice with cream"]
    )
    
    let recipes = [allergenFreeRecipe, dairyRecipe]
    let filter = RecipeFilter(dietaryRules: [AllergenRule(allergen: .dairy)])
    
    // Act
    let filteredRecipes = filter.filter(recipes: recipes)
    
    // Assert
    #expect(filteredRecipes.count == 1)
    #expect(filteredRecipes.first?.name == "Plain Rice")
}

@Test func testRecipeFilterWithMultipleAllergens() async throws {
    // Arrange
    let allergenFreeIngredient = Ingredient(
        name: "Rice",
        dietaryRestrictions: [.vegan, .glutenFree],
        allergens: [],
        flavorProfile: []
    )
    
    let dairyIngredient = Ingredient(
        name: "Cream",
        dietaryRestrictions: [.vegetarian],
        allergens: [.dairy],
        flavorProfile: []
    )
    
    let nutIngredient = Ingredient(
        name: "Almonds",
        dietaryRestrictions: [.vegan],
        allergens: [.nuts],
        flavorProfile: []
    )
    
    let allergenFreeRecipe = Recipe(
        name: "Plain Rice",
        description: "",
        ingredients: [allergenFreeIngredient],
        instructions: ["Cook rice"]
    )
    
    let dairyRecipe = Recipe(
        name: "Creamy Rice",
        description: "",
        ingredients: [allergenFreeIngredient, dairyIngredient],
        instructions: ["Cook rice with cream"]
    )
    
    let nutRecipe = Recipe(
        name: "Almond Rice",
        description: "",
        ingredients: [allergenFreeIngredient, nutIngredient],
        instructions: ["Cook rice with almonds"]
    )
    
    let recipes = [allergenFreeRecipe, dairyRecipe, nutRecipe]
    let filter = RecipeFilter(dietaryRules: [
        AllergenRule(allergens: [.dairy, .nuts])
    ])
    
    // Act
    let filteredRecipes = filter.filter(recipes: recipes)
    
    // Assert
    #expect(filteredRecipes.count == 1)
    #expect(filteredRecipes.first?.name == "Plain Rice")
}
