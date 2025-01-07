import Testing
@testable import RecipeKit

@Test func testRecipeFilterWithVeganRule() async throws {
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
    
    // Act
    let filteredRecipes = filter.filter(recipes: recipes)
    
    // Assert
    #expect(filteredRecipes.count == 1)
    #expect(filteredRecipes.first?.name == "Carrot Soup")
}

@Test func testRecipeFilterWithMultipleDietaryRestrictions() async throws {
    // Arrange
    let veganGlutenFreeIngredient = Ingredient(
        name: "Rice",
        dietaryRestrictions: [.vegan, .glutenFree],
        allergens: [],
        flavorProfile: []
    )
    
    let veganWithGlutenIngredient = Ingredient(
        name: "Seitan",
        dietaryRestrictions: [.vegan],
        allergens: [],
        flavorProfile: []
    )
    
    let nonVeganGlutenFreeIngredient = Ingredient(
        name: "Eggs",
        dietaryRestrictions: [.glutenFree],
        allergens: [],
        flavorProfile: []
    )
    
    let compliantRecipe = Recipe(
        name: "Plain Rice",
        description: "",
        ingredients: [veganGlutenFreeIngredient],
        instructions: ["Cook rice"]
    )
    
    let veganWithGlutenRecipe = Recipe(
        name: "Seitan Stir Fry",
        description: "",
        ingredients: [veganGlutenFreeIngredient, veganWithGlutenIngredient],
        instructions: ["Stir fry seitan with rice"]
    )
    
    let glutenFreeNonVeganRecipe = Recipe(
        name: "Egg Fried Rice",
        description: "",
        ingredients: [veganGlutenFreeIngredient, nonVeganGlutenFreeIngredient],
        instructions: ["Cook rice with eggs"]
    )
    
    let recipes = [compliantRecipe, veganWithGlutenRecipe, glutenFreeNonVeganRecipe]
    
    let filter = RecipeFilter(dietaryRules: [
        VeganRule(),
        GlutenFreeRule()
    ])
    
    // Act
    let filteredRecipes = filter.filter(recipes: recipes)
    
    // Assert
    #expect(filteredRecipes.count == 1)
    #expect(filteredRecipes.first?.name == "Plain Rice")
}
