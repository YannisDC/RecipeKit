//
//  ContentView.swift
//  Example
//
//  Created by Yannis De Cleene on 30/12/2024.
//

import SwiftUI
import SwiftData
import RecipeKit

struct ContentView: View {
    @State private var selectedDietaryRestrictions: Set<DietaryRestriction> = []
    @State private var selectedAllergens: Set<Allergen> = []
    @State private var recipes: [Recipe] = [
        Recipe(
            name: "Carrot Soup",
            description: "",
            ingredients: [
                BaseIngredients.onion,
                Ingredient(
                    name: "Carrot",
                    dietaryRestrictions: [.vegan, .glutenFree, .vegetarian],
                    allergens: [],
                    flavorProfile: [.sweet]
                )
            ],
            instructions: ["Sauté onions", "Add carrots and cook until tender"]
        ),
        Recipe(
            name: "Buttered Toast",
            description: "",
            ingredients: [
                BaseIngredients.butter,
                Ingredient(
                    name: "Bread",
                    dietaryRestrictions: [.vegetarian],
                    allergens: [.gluten],
                    flavorProfile: []
                )
            ],
            instructions: ["Toast bread", "Spread butter"]
        )
    ]
    
    var filteredRecipes: [Recipe] {
        let preferences = UserDietaryPreferences(
            dietaryRestrictions: selectedDietaryRestrictions,
            allergens: selectedAllergens
        )
        let filter = preferences.createRecipeFilter()
        return filter.filter(recipes: recipes)
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                Section("Dietary Restrictions") {
                    Toggle("Vegan", isOn: binding(for: .vegan))
                    Toggle("Gluten Free", isOn: binding(for: .glutenFree))
                    Toggle("Vegetarian", isOn: binding(for: .vegetarian))
                }
                
                Section("Allergens") {
                    Toggle("Dairy", isOn: allergenBinding(for: .dairy))
                    Toggle("Nuts", isOn: allergenBinding(for: .nuts))
                    Toggle("Gluten", isOn: allergenBinding(for: .gluten))
                }
                
                Section("Filtered Recipes") {
                    ForEach(filteredRecipes, id: \.name) { recipe in
                        NavigationLink {
                            RecipeDetailView(recipe: recipe)
                        } label: {
                            Text(recipe.name)
                        }
                    }
                }
            }
            .navigationTitle("Recipe Filter")
        } detail: {
            Text("Select a recipe")
        }
    }
    
    private func binding(for restriction: DietaryRestriction) -> Binding<Bool> {
        Binding(
            get: { selectedDietaryRestrictions.contains(restriction) },
            set: { isSelected in
                if isSelected {
                    selectedDietaryRestrictions.insert(restriction)
                } else {
                    selectedDietaryRestrictions.remove(restriction)
                }
            }
        )
    }
    
    private func allergenBinding(for allergen: Allergen) -> Binding<Bool> {
        Binding(
            get: { selectedAllergens.contains(allergen) },
            set: { isSelected in
                if isSelected {
                    selectedAllergens.insert(allergen)
                } else {
                    selectedAllergens.remove(allergen)
                }
            }
        )
    }
}

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        List {
            Section("Ingredients") {
                ForEach(recipe.ingredients, id: \.name) { ingredient in
                    VStack(alignment: .leading) {
                        Text(ingredient.name)
                            .font(.headline)
                        
                        if !ingredient.dietaryRestrictions.isEmpty {
                            Text("Dietary: " + ingredient.dietaryRestrictions.map(\.name).joined(separator: ", "))
                                .font(.caption)
                        }
                        
                        if !ingredient.allergens.isEmpty {
                            Text("Allergens: " + ingredient.allergens.map(\.name).joined(separator: ", "))
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            
            Section("Instructions") {
                ForEach(recipe.instructions, id: \.self) { instruction in
                    Text(instruction)
                }
            }
        }
        .navigationTitle(recipe.name)
    }
}

#Preview {
    ContentView()
}
