//
//  NetWorlkUtil.swift
//  Recipes
//
//  Created by Андрей Олесов on 9/24/19.
//  Copyright © 2019 Andrei Olesau. All rights reserved.
//

import Foundation

class NetWorkUtil{
    let headers = [
        "x-rapidapi-host": "recipe-puppy.p.rapidapi.com",
        "x-rapidapi-key": "641a3bc99amshc24129c2ec9445dp1253f9jsn94586960f308"
    ]

    var recipes = [Recipe]()
    
    private let defaultUrl = "https://recipe-puppy.p.rapidapi.com/"

    public func getRecipes(){
        let headers = [
            "x-rapidapi-host": "recipe-puppy.p.rapidapi.com",
            "x-rapidapi-key": "641a3bc99amshc24129c2ec9445dp1253f9jsn94586960f308"
        ]

        guard let url = URL(string: "https://recipe-puppy.p.rapidapi.com/?p=1&i=onions%2Cgarlic&q=omelet") else {return}
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
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
                    self.recipes = results
            }
            catch{
                print("LOG: Error while fettching result")
            }
            }).resume()
        

        return
        
    }
    

    
}

