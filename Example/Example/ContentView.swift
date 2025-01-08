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
    @StateObject private var preferencesManager = PreferencesManager.shared
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
        let filter = preferencesManager.preferences.createRecipeFilter()
        return filter.filter(recipes: recipes)
    }
    
    var body: some View {
        TabView {
            RecipeListView(recipes: filteredRecipes)
                .tabItem {
                    Label("Recipes", systemImage: "list.bullet")
                }
            
            PreferencesView()
                .tabItem {
                    Label("Preferences", systemImage: "gear")
                }
        }
    }
}

struct RecipeListView: View {
    let recipes: [Recipe]
    
    var body: some View {
        NavigationSplitView {
            List {
                Section("Filtered Recipes") {
                    ForEach(recipes, id: \.name) { recipe in
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
