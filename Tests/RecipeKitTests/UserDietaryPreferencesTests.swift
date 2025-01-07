import Testing
@testable import RecipeKit

@Test func testUserDietaryPreferencesFilter() async throws {
    // Arrange
    let preferences = UserDietaryPreferences(
        dietaryRestrictions: [.vegan],
        allergens: [.nuts],
        excludedIngredients: ["Onion"]
    )
    
    let veganSafeIngredient = Ingredient(
        name: "Carrot",
        dietaryRestrictions: [.vegan],
        allergens: [],
        flavorProfile: []
    )
    
    let nutIngredient = Ingredient(
        name: "Almond",
        dietaryRestrictions: [.vegan],
        allergens: [.nuts],
        flavorProfile: []
    )
    
    let excludedIngredient = Ingredient(
        name: "Onion",
        dietaryRestrictions: [.vegan],
        allergens: [],
        flavorProfile: []
    )

    let nonVeganIngredient = Ingredient(
        name: "Chicken",
        dietaryRestrictions: [],
        allergens: [],
        flavorProfile: []
    )

    let nonVeganRecipe = Recipe(
        name: "Chicken Soup",
        description: "",
        ingredients: [nonVeganIngredient],
        instructions: ["Cook chicken"]
    )
    
    let safeRecipe = Recipe(
        name: "Carrot Soup",
        description: "",
        ingredients: [veganSafeIngredient],
        instructions: ["Cook carrots"]
    )
    
    let nutRecipe = Recipe(
        name: "Carrot Almond Soup",
        description: "",
        ingredients: [veganSafeIngredient, nutIngredient],
        instructions: ["Cook carrots with almonds"]
    )
    
    let excludedIngredientRecipe = Recipe(
        name: "Carrot Onion Soup",
        description: "",
        ingredients: [veganSafeIngredient, excludedIngredient],
        instructions: ["Cook carrots with onions"]
    )
    
    let recipes = [safeRecipe, nutRecipe, excludedIngredientRecipe, nonVeganRecipe]
    
    // Act
    let filter = preferences.createRecipeFilter()
    let filteredRecipes = filter.filter(recipes: recipes)
    
    // Assert
    #expect(filteredRecipes.count == 1)
    #expect(filteredRecipes.first?.name == "Carrot Soup")
}

@Test func testEmptyPreferences() async throws {
    // Arrange
    let preferences = UserDietaryPreferences()
    
    let ingredient = Ingredient(
        name: "Carrot",
        dietaryRestrictions: [.vegan],
        allergens: [],
        flavorProfile: []
    )
    
    let recipe = Recipe(
        name: "Carrot Soup",
        description: "",
        ingredients: [ingredient],
        instructions: ["Cook carrots"]
    )
    
    // Act
    let filter = preferences.createRecipeFilter()
    let filteredRecipes = filter.filter(recipes: [recipe])
    
    // Assert
    #expect(filteredRecipes.count == 1)
    #expect(filteredRecipes.first?.name == "Carrot Soup")
}
