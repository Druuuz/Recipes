//
//  TableViewController.swift
//  Recipes
//
//  Created by Андрей Олесов on 9/24/19.
//  Copyright © 2019 Andrei Olesau. All rights reserved.
//

import UIKit
import Foundation

class TableViewController: UITableViewController {

    private var currentPageOfRecipes:Int = 1
    private var recipes:[Recipe] = [Recipe]()
    private var currentRequest:URLRequest?
    private var currentRecipeForSearch:String?

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let VC = segue.destination as? RecipeDetailViewController
        if let VC = VC, let recipe = sender as? Recipe{
            VC.recipe = recipe
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowRecipeDetail", sender: recipes[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as? RecipeTableViewCell
        
        let recipe = recipes[indexPath.row]
        
        if let cell = cell{
            cell.recipe = recipe
            return cell
        }
        return UITableViewCell()
    }
    
    public func getRecipes(){
        currentRequest = RecipesApi.getUrl(forPage: currentPageOfRecipes, withIngredients: nil, withTitle: currentRecipeForSearch)
        guard let request = currentRequest else{return}
        RecipesApi.getRecipes(withRequest: request) { recipesFromRequest in
            self.recipes.append(contentsOf: recipesFromRequest)
            DispatchQueue.main.async { 
               self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = recipes.count - 1
        if indexPath.row == lastItem - 1{
            self.currentPageOfRecipes = self.currentPageOfRecipes + 1
            getRecipes()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }

}

extension TableViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.recipes = [Recipe]()
        tableView.reloadData()
        currentPageOfRecipes = 1
        currentRecipeForSearch = searchBar.text
        getRecipes()
        self.view.endEditing(true)
    }
}
