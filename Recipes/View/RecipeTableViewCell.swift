//
//  RecipeTableViewCell.swift
//  Recipes
//
//  Created by Андрей Олесов on 9/24/19.
//  Copyright © 2019 Andrei Olesau. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var photo: UIImageView!
    
    var recipe:Recipe?{
        didSet{
            photo.image = UIImage(named:"empty")
            title.text = recipe?.title?.trimmingCharacters(in: .whitespacesAndNewlines)
            DispatchQueue.global().async {
                if let url = self.recipe?.thumbnail, let imageUrl = URL(string: url), let data = try? Data(contentsOf: imageUrl){
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.photo.image = image
                    }
                } 
            }
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
