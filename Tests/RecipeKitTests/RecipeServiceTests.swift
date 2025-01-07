import Testing
@testable import RecipeKit

@Test func testRecipeServiceWithVeganFilter() async throws {
    // Arrange
    let veganIngredient = Ingredient(
        name: "Carrot",
        dietaryRestrictions: [.vegan],
        allergens: [],
        flavorProfile: []
    )
    
    let nonVeganIngredient = Ingredient(
        name: "Butter",
        dietaryRestrictions: [.vegetarian],
        allergens: [.dairy],
        flavorProfile: []
    )
    
    let veganRecipe = Recipe(
        name: "Carrot Soup",
        description: "",
        ingredients: [veganIngredient],
        instructions: ["Cook the carrots"]
    )
    
    let nonVeganRecipe = Recipe(
        name: "Buttered Carrots",
        description: "",
        ingredients: [veganIngredient, nonVeganIngredient],
        instructions: ["Cook carrots with butter"]
    )
    
    let recipes = [veganRecipe, nonVeganRecipe]
    let filter = RecipeFilter(dietaryRules: [VeganRule()])
    let service = RecipeService(filter: filter)
    
    // Act
    let filteredRecipes = service.getFilteredRecipes(from: recipes)
    
    // Assert
    #expect(filteredRecipes.count == 1)
    #expect(filteredRecipes.first?.name == "Carrot Soup")
}

@Test func testRecipeServiceWithAllergenFilter() async throws {
    // Arrange
    let allergenFreeIngredient = Ingredient(
        name: "Rice",
        dietaryRestrictions: [.vegan],
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
    let service = RecipeService(filter: filter)
    
    // Act
    let filteredRecipes = service.getFilteredRecipes(from: recipes)
    
    // Assert
    #expect(filteredRecipes.count == 1)
    #expect(filteredRecipes.first?.name == "Plain Rice")
}

@Test func testRecipeServiceWithMultipleFilters() async throws {
    // Arrange
    let veganAllergenFreeIngredient = Ingredient(
        name: "Rice",
        dietaryRestrictions: [.vegan],
        allergens: [],
        flavorProfile: []
    )
    
    let nonVeganIngredient = Ingredient(
        name: "Butter",
        dietaryRestrictions: [.vegetarian],
        allergens: [.dairy],
        flavorProfile: []
    )
    
    let veganNutIngredient = Ingredient(
        name: "Almonds",
        dietaryRestrictions: [.vegan],
        allergens: [.nuts],
        flavorProfile: []
    )
    
    let safeRecipe = Recipe(
        name: "Plain Rice",
        description: "",
        ingredients: [veganAllergenFreeIngredient],
        instructions: ["Cook rice"]
    )
    
    let nonVeganRecipe = Recipe(
        name: "Buttered Rice",
        description: "",
        ingredients: [veganAllergenFreeIngredient, nonVeganIngredient],
        instructions: ["Cook rice with butter"]
    )
    
    let nutRecipe = Recipe(
        name: "Almond Rice",
        description: "",
        ingredients: [veganAllergenFreeIngredient, veganNutIngredient],
        instructions: ["Cook rice with almonds"]
    )
    
    let recipes = [safeRecipe, nonVeganRecipe, nutRecipe]
    let filter = RecipeFilter(dietaryRules: [
        VeganRule(),
        AllergenRule(allergens: [.dairy, .nuts])
    ])
    let service = RecipeService(filter: filter)
    
    // Act
    let filteredRecipes = service.getFilteredRecipes(from: recipes)
    
    // Assert
    #expect(filteredRecipes.count == 1)
    #expect(filteredRecipes.first?.name == "Plain Rice")
} 
