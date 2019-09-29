//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Андрей Олесов on 9/27/19.
//  Copyright © 2019 Andrei Olesau. All rights reserved.
//

import UIKit
import SafariServices

class RecipeDetailViewController: UIViewController {


    @IBOutlet var webSiteButton: UIButton!
    @IBOutlet var ingredients: UILabel!
    @IBOutlet var photo: UIImageView!
    @IBOutlet var recipeTitile: UILabel!
    var recipe:Recipe?
    
    func setViewByRecipe(){
        guard let recipeModel = recipe else {return}
        recipeTitile.text = recipeModel.title?.trimmingCharacters(in: .whitespacesAndNewlines)
        ingredients.text = recipeModel.ingredients

        if let _ = recipe?.href{
            webSiteButton.isEnabled = true
        } else{
            webSiteButton.isEnabled = false
        }
        
        DispatchQueue.global().async {
            if let url = self.recipe?.thumbnail, let imageUrl = URL(string: url), let data = try? Data(contentsOf: imageUrl){
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.photo.image = image
                }
            } else{
                DispatchQueue.main.async {
                    self.photo.image = UIImage(named: "empty")
                    self.photo.image?.withTintColor(.white)
                }
        
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setViewByRecipe()
        
    }
    
    override func viewDidLoad() {
        navigationItem.largeTitleDisplayMode = .never
    }

    @IBAction func seeOnWebSiteAction(_ sender: UIButton) {
        guard let url = URL(string: recipe?.href ?? "") else {return}
               let safariVC = SFSafariViewController(url: url)
               present(safariVC, animated: true)
    }
}
