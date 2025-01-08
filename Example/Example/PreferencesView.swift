import SwiftUI
import RecipeKit

struct PreferencesView: View {
    @StateObject private var preferencesManager = PreferencesManager.shared
    @State private var excludedIngredients: String
    
    init() {
        // Initialize excluded ingredients from preferences
        _excludedIngredients = State(
            initialValue: PreferencesManager.shared.preferences.excludedIngredients.joined(separator: ", ")
        )
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Dietary Restrictions") {
                    ForEach(BaseDietaryRestrictions.all, id: \.name) { restriction in
                        Toggle(restriction.name.capitalized, isOn: binding(for: restriction))
                    }
                }
                
                Section("Allergens") {
                        ForEach(BaseAllergens.all, id: \.name) { allergen in
                        Toggle(allergen.name, isOn: allergenBinding(for: allergen))
                    }
                }
                
                Section("Excluded Ingredients") {
                    TextField("Enter ingredients (comma-separated)", text: $excludedIngredients)
                        .onChange(of: excludedIngredients) { _, newValue in
                            var newPreferences = preferencesManager.preferences
                            let ingredients = newValue
                                .split(separator: ",")
                                .map { $0.trimmingCharacters(in: .whitespaces) }
                            newPreferences.excludedIngredients = Set(ingredients)
                            preferencesManager.updatePreferences(newPreferences)
                        }
                }
            }
            .navigationTitle("Dietary Preferences")
        }
    }
    
    private func binding(for restriction: DietaryRestriction) -> Binding<Bool> {
        Binding(
            get: { preferencesManager.preferences.dietaryRestrictions.contains(restriction) },
            set: { isSelected in
                var newPreferences = preferencesManager.preferences
                if isSelected {
                    newPreferences.dietaryRestrictions.insert(restriction)
                } else {
                    newPreferences.dietaryRestrictions.remove(restriction)
                }
                preferencesManager.updatePreferences(newPreferences)
            }
        )
    }
    
    private func allergenBinding(for allergen: Allergen) -> Binding<Bool> {
        Binding(
            get: { preferencesManager.preferences.allergens.contains(allergen) },
            set: { isSelected in
                var newPreferences = preferencesManager.preferences
                if isSelected {
                    newPreferences.allergens.insert(allergen)
                } else {
                    newPreferences.allergens.remove(allergen)
                }
                preferencesManager.updatePreferences(newPreferences)
            }
        )
    }
}

#Preview {
    PreferencesView()
} 