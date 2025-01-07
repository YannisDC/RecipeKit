# RecipeKit

RecipeKit is a powerful Swift package for handling recipes, dietary restrictions, and ingredient substitutions. It provides a flexible and extensible framework for managing recipes while considering various dietary needs, allergens, and taste profiles.

## Features

- 🥗 **Dietary Restriction Handling**

  - Support for common dietary restrictions (vegan, vegetarian, gluten-free, etc.)
  - Customizable dietary rules and filters
  - Easy to extend with new dietary restrictions

- 🚫 **Allergen Management**

  - Built-in support for common allergens (dairy, nuts, gluten, etc.)
  - Allergen-based recipe filtering
  - Safe ingredient substitution recommendations

- 🔄 **Intelligent Ingredient Substitution**

  - Context-aware ingredient substitutions
  - Taste profile matching
  - Multiple substitution strategies
  - Scored substitution recommendations

- 👅 **Taste Profile Support**
  - Basic taste categories (sweet, sour, salty, bitter, umami)
  - Flavor profile matching
  - Taste-based ingredient substitutions

## Installation

### Swift Package Manager

RecipeKit can be installed using Swift Package Manager. Add it as a dependency in your `Package.swift` file:

```swift
dependencies: [
.package(url: "https://github.com/YannisDC/RecipeKit.git", from: "1.0.0")
]
```

Or in Xcode:

1. Go to File > Add Packages...
2. Enter the package repository URL: `https://github.com/YannisDC/RecipeKit.git`
3. Select the version you want to use
4. Click "Add Package"

### Requirements

- iOS 13.0+ / macOS 10.15+
- Swift 5.5+
- Xcode 13.0+
