//
//  CookbookViewController.swift
//  cookbook
//
//  Created by Jishan Kurane on 26/02/25.
//

import Foundation
import UIKit
class CookbookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Use small quotes
    let quotes = [
        "",
        "A recipe has no soul. You, as the cook, must bring soul to the recipe.",
        "Food is symbolic of love when words are inadequate.",
        "The secret of good cooking is, first, having a love of it.",
        "The more you know, the more you can create.",
        "People who love to eat are always the best people.",
        "Cooking is love made visible.",
        "A recipe is a story that ends with a good meal.",
        "Happiness is homemade.",
        "The secret ingredient is always love.",
        "Good food, good mood.",
        "Eat well, laugh often, love much.",
        "Cooking is an art, baking is a science.",
        "Season everything with love.",
        "Life is too short for bad food.",
        "Food tastes better when shared.",
        "Made with love and butter.",
        "Savor the moment, one bite at a time.",
        "A kitchen is the heart of a home.",
        "Great food, great memories.",
        "Cooking is like magic, but edible.",
        "Flavors are memories in the making.",
        "Simple ingredients, extraordinary meals.",
        "A pinch of patience, a dash of kindness.",
        "Cooking fuels the soul.",
        "Eat, cook, repeat!"
    ]

    @IBOutlet weak var quoteLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!
    
    var recipes: [Recipe] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44  // Adjust as needed
         
        let hasSeenAlert = UserDefaults.standard.bool(forKey: "hasSeenAppLaunchAlert")

        if !hasSeenAlert {
                
            let alert = UIAlertController(title: "Welcome to CookBook - the recipe app",message: "Tap a recipe to view details.", preferredStyle: .alert)
                
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
            self.present(alert, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "hasSeenAppLaunchAlert")
            }

        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipes = RecipeManager.shared.loadRecipes()
        tableView.reloadData()
        
        // Pick a random quote and display it
        quoteLabel.text = quotes.randomElement()
        // Ensure the label resizes dynamically
        quoteLabel.sizeToFit()
    }

    // MARK: - TableView Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        let recipe = recipes[indexPath.row]

        // Set text to show all details properly
        cell.textLabel?.text = recipe.name
        cell.textLabel?.numberOfLines = 0  // Allow multiline name

        cell.detailTextLabel?.text = "Ingredients: \(recipe.ingredients)\nSteps: \(recipe.steps)"
        cell.detailTextLabel?.numberOfLines = 0  // Allow multiline ingredients and steps

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = recipes[indexPath.row]

        // Load the RecipeDetailViewController from Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "RecipeDetailVC") as? RecipeDetailViewController {
            
            // Pass data to the detail screen
            detailVC.recipeName = selectedRecipe.name
            detailVC.recipeIngredients = selectedRecipe.ingredients
            detailVC.recipeSteps = selectedRecipe.steps

            // Navigate to RecipeDetailViewController
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

}
