//
//  RecipesApi.swift
//  Recipes
//
//  Created by Андрей Олесов on 9/26/19.
//  Copyright © 2019 Andrei Olesau. All rights reserved.
//

import Foundation

class RecipesApi{
    private static let headers = [
        "x-rapidapi-host": "recipe-puppy.p.rapidapi.com",
        "x-rapidapi-key": "641a3bc99amshc24129c2ec9445dp1253f9jsn94586960f308"
    ]

    private static let defaultUrl = "https://recipe-puppy.p.rapidapi.com/"
    
    public static func getUrl(forPage number:Int, withIngredients ingredients:[String]?, withTitle title:String?) -> URLRequest?{
        
        var stringUrl = defaultUrl + "?" + "p=\(number)"
        if let ingredients = ingredients{
            stringUrl = stringUrl + "&i=" + ingredients.joined(separator: "%2C")
        }
        
        if let title = title{
            stringUrl = stringUrl + "&q=\(title)"
        }
        
        guard let url = URL(string: stringUrl) else {return nil}
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
    
    class func getRecipes(withRequest request:URLRequest, completion: @escaping ([Recipe])->()){
       URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
                  
       guard let data = data, let _ = response, error == nil else {
           print("LOG: Incorrect response from endpoint \(String(describing: error))")
           return
       }
       print("LOG: Downloded...")
       do{
           let jsonDecoder = JSONDecoder()
           let dataJson = try jsonDecoder.decode(ResponseJson.self, from: data)
           print(dataJson)
           guard let results = dataJson.results else {return}
           completion(results)
        }
        catch{
           print("LOG: Error while fettching result")
        }
        }).resume()
               
        return
    }

}
