//
//  MoreViewController.swift
//  cookbook
//
//  Created by Jishan Kurane on 26/02/25.
//

import Foundation
import UIKit

class MoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var recipes: [Recipe] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44  // Adjust as needed
        
        let hasSeenMoreAlert = UserDefaults.standard.bool(forKey: "hasSeenMoreAlert")

            if !hasSeenMoreAlert {
                let alert = UIAlertController(title: "More", message: "Here you can edit or delete recipes. Click to edit and swipe left to delete.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
                UserDefaults.standard.set(true, forKey: "hasSeenMoreAlert")
            }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRecipes()
    }

    func loadRecipes() {
        recipes = RecipeManager.shared.loadRecipes()
        tableView.reloadData()
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

    // MARK: - Edit Recipe (Tap to Edit)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let editVC = storyboard.instantiateViewController(withIdentifier: "EditVC") as? EditViewController {
            editVC.recipe = recipes[indexPath.row]
            editVC.recipeIndex = indexPath.row
            navigationController?.pushViewController(editVC, animated: true)
        }
    }

    // MARK: - Swipe to Delete Recipe
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            RecipeManager.shared.deleteRecipe(at: indexPath.row)
            loadRecipes()
        }
    }
}
