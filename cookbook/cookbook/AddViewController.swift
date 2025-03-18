//
//  AddViewController.swift
//  cookbook
//
//  Created by Jishan Kurane on 26/02/25.
//

import Foundation
import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var stepsTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hasSeenAddAlert = UserDefaults.standard.bool(forKey: "hasSeenAddAlert")

            if !hasSeenAddAlert {
                let alert = UIAlertController(title: "Add a Recipe", message: "Enter new recipes by filling Name, Ingredients and Steps. Tap Submit to add recipe.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
                UserDefaults.standard.set(true, forKey: "hasSeenAddAlert")
            }
        
    }

    @IBAction func submitRecipe(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let ingredients = ingredientsTextField.text, !ingredients.isEmpty,
              let steps = stepsTextField.text, !steps.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }

        let newRecipe = Recipe(name: name, ingredients: ingredients, steps: steps)
        RecipeManager.shared.saveRecipe(newRecipe)

        nameTextField.text = ""
        ingredientsTextField.text = ""
        stepsTextField.text = ""

        showAlert(message: "Recipe added successfully!")
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
