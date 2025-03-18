//
//  EditViewController.swift
//  cookbook
//
//  Created by Jishan Kurane on 26/02/25.
//

import Foundation
import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var stepsTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!

    var recipeIndex: Int?
    var recipe: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recipe = recipe {
            nameTextField.text = recipe.name
            ingredientsTextField.text = recipe.ingredients
            stepsTextField.text = recipe.steps
        }
    }

    @IBAction func saveChanges(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let ingredients = ingredientsTextField.text, !ingredients.isEmpty,
              let steps = stepsTextField.text, !steps.isEmpty,
              let index = recipeIndex else {
            showAlert(message: "Please fill all fields.")
            return
        }

        var recipes = RecipeManager.shared.loadRecipes()
        recipes[index] = Recipe(name: name, ingredients: ingredients, steps: steps)

        if let encodedData = try? JSONEncoder().encode(recipes) {
            UserDefaults.standard.set(encodedData, forKey: "recipes")
        }

        navigationController?.popViewController(animated: true)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
