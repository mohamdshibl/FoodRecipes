//
//  RecipesModel.swift
//  FoodRecipe
//
//  Created by Mohamed Shibl on 18/08/2022.
//

import Foundation

// MARK: - Welcome
struct RecipeWelcome: Codable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int?
    let hits: [Hit]?
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe?
}

// MARK: - Recipe
struct Recipe: Codable {
    let uri: String?
    let label: String?
    let image: String?
    let source: String?
    let url: String?
    let shareAs: String?
    let yield: Int?
    let dietLabels, healthLabels, cautions, ingredientLines: [String]
    let ingredients: [Ingredient]?
    let calories, totalWeight: Double?
    let cuisineType: [String]?
    var mealType: [String]?
    let totalNutrients, totalDaily: [String: Total]?
    let digest: [Digest]?
}

// MARK: - Digest
struct Digest: Codable {
    let label, tag: String?
    let schemaOrgTag: String?
    let total: Double?
    let hasRDI: Bool?
    let daily: Double?
    let unit: String?
    let sub: [Digest]?
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String?
    let quantity: Double?
    let measure: String?
    let food: String?
    let weight: Double?
    let foodCategory, foodID: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight, foodCategory
        case foodID = "foodId"
        case image
    }
}

// MARK: - Total
struct Total: Codable {
    let label: String?
    let quantity: Double?
    let unit: String?
}
