//
//  SearchPresenter.swift
//  FoodRecipe
//
//  Created by Mohamed Shibl on 19/08/2022.
//

import Foundation
import UIKit

//MARK: - TypeAlies

typealias PresnterDelegate = SearchPresenterDelegate & UIViewController


protocol SearchPresenterDelegate {
    
    func showRecpies(Recpies: [Hit])
    func showError(msg: String)
}

class SearchPresenter {

    // MARK: - Properties
    
    private let recipesManager: NetworkManager = RecipesManager()
    weak var presenterDelegate: PresnterDelegate?
    
    
    
    //MARK: - Set View Delegate
    
    func setViewDelegate(delegate: PresnterDelegate) {
        self.presenterDelegate = delegate
    }
    
    // MARK: - Methods
    
    func fetchRecipes(recipeName: String?) {
        
        recipesManager.fetchByRecipeName(recipeName: recipeName, compeletionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let recipesWelcome):
                self.convertToViewModel(recpies: recipesWelcome.hits ?? [])
             //  print("shibl")
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func convertToViewModel(recpies: [Hit]) {
        
        self.presenterDelegate?.showRecpies(Recpies: recpies)
    }
}
