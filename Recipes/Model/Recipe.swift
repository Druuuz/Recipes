//
//  Recipe.swift
//  Recipes
//
//  Created by Андрей Олесов on 9/24/19.
//  Copyright © 2019 Andrei Olesau. All rights reserved.
//

import Foundation

class ResponseJson:Codable{
    let title:String?
    let version:Double?
    let href:String?
    let results:[Recipe]?
}

class Recipe:Codable{
    let title:String?
    let ingredients:String?
    let href:String?
    let thumbnail:String?
    
    init(title:String?, ingredients:String?, href:String?, thumbnail:String?) {
        self.title = title
        self.ingredients = ingredients
        self.thumbnail = thumbnail
        self.href = href
    }
}
