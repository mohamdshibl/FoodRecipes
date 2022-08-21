//
//  RecipesManager.swift
//  FoodRecipe
//
//  Created by Mohamed Shibl on 19/08/2022.
//


import Alamofire

enum Enviroment {
    
    static let baseURL: String = "https://api.edamam.com/search?q="
    
}

protocol NetworkManager {
    
    func fetchByRecipeName(recipeName: String?, compeletionHandler: @escaping (Result<RecipeWelcome, AFError>) -> Void )
}

struct RecipesManager: NetworkManager {
    
    private let appKey = "f5063285d6548e0db8adecd09fde9b09"
    private let appId = "e588d4ed"
    
    private func requestURLBuilder(recipeName: String?) -> String {
        
        Enviroment.baseURL+"\(recipeName ?? "all")&app_id=e588d4ed&app_key=f5063285d6548e0db8adecd09fde9b09"
    }
    
    func fetchByRecipeName(recipeName: String?, compeletionHandler: @escaping (Result<RecipeWelcome, AFError>) -> Void ) {
        AF.request(requestURLBuilder(recipeName: recipeName))
            .validate()
            .responseDecodable(of: RecipeWelcome.self,
                               queue: .main,
                               decoder: JSONDecoder()) { result in
                
                print(result.request as Any)
                print(result.response as Any)
                print(result.data as Any)
                print(result.result)
                switch result.result {
                
                case .success(let recipes):
                    compeletionHandler(.success(recipes))
                    
                case .failure(let error):
                    compeletionHandler(.failure(error))
                    print(error.localizedDescription)
                }
            }

    }
}
