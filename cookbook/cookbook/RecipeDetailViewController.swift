//
//  RecipeDetailViewController.swift
//  cookbook
//
//  Created by Jishan Kurane on 27/02/25.
//

import Foundation
import UIKit

class RecipeDetailViewController: UIViewController {
    
    // Outlets for UI elements
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var stepsTextView: UITextView!
    
    // Variables to hold recipe data
    var recipeName: String?
    var recipeIngredients: String?
    var recipeSteps: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign text
        nameLabel.text = recipeName
        ingredientsTextView.text = "Ingredients:\n\(recipeIngredients ?? "N/A")"
        stepsTextView.text = "Steps:\n\(recipeSteps ?? "N/A")"
        
        // Ensure the TextView expands based on content
        stepsTextView.isScrollEnabled = true
        stepsTextView.sizeToFit() // Makes sure it resizes to fit content
    }

}
