//
//  RecipeManager.swift
//  cookbook
//
//  Created by Jishan Kurane on 26/02/25.
//

import Foundation

class RecipeManager {
    static let shared = RecipeManager()
    private let recipesKey = "recipes"

    private init() {}

    func saveRecipe(_ recipe: Recipe) {
        var recipes = loadRecipes()
        recipes.append(recipe)
        if let encodedData = try? JSONEncoder().encode(recipes) {
            UserDefaults.standard.set(encodedData, forKey: recipesKey)
        }
    }

    func loadRecipes() -> [Recipe] {
        if let savedData = UserDefaults.standard.data(forKey: recipesKey),
           let decodedRecipes = try? JSONDecoder().decode([Recipe].self, from: savedData) {
            return decodedRecipes
        }
        return []
    }

    func deleteRecipe(at index: Int) {
        var recipes = loadRecipes()
        if index < recipes.count {
            recipes.remove(at: index)
            if let encodedData = try? JSONEncoder().encode(recipes) {
                UserDefaults.standard.set(encodedData, forKey: recipesKey)
            }
        }
    }
}
