//
//  ViewController.swift
//  FoodRecipe
//
//  Created by Mohamed Shibl on 19/08/2022.
//

import UIKit

class SearchVC: PresnterDelegate {
    
    @IBOutlet weak private var recipeTableView: UITableView!
    @IBOutlet weak private var recipeSearchBar: UITextField!
   
    private var recipes: [Hit]?
    private let presenter = SearchPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        presenter.setViewDelegate(delegate: self)
        presenter.fetchRecipes(recipeName: "all")
        recipeSearchBar.addTarget(self,
                                  action: #selector(searchRecipe(textField: )),
                                  for: .editingChanged)
        
    }
    //self.presenter.fetchRecipes(recipeName: textField.text)
    @objc final private func searchRecipe(textField: UITextField) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            if textField.text == "" {
                self.presenter.fetchRecipes(recipeName: "All")
            } else{
                self.presenter.fetchRecipes(recipeName: textField.text)
            }
        }
       
        
    }
    
    
    func showRecpies(Recpies: [Hit]) {
        self.recipes = Recpies
        
        reloadTableView()
    }
    
    func showError(msg: String) {
        print("error")
    }
    
    private func setupTableView() {
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        recipeTableView.register(UINib(nibName: "RecipeListCell", bundle: nil), forCellReuseIdentifier: "RecipeListCell")
        
        reloadTableView()
    }
    func reloadTableView() {
        
        recipeTableView.reloadData()
    }
}

extension SearchVC: UITableViewDataSource{
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        recipes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipeListCell", for: indexPath) as! RecipeListCell
        guard let recipe = recipes![indexPath.row].recipe else {
            return cell
        }
        cell.recipeTitle.text = recipe.label
        cell.recipeHealthLabels.text = recipe.healthLabels.first
        cell.source.text = recipe.source
        cell.recipeImage.fetchImageFromUrl(recipe.image!)

        return cell
    }
}

extension SearchVC: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let details = storyboard?.instantiateViewController(withIdentifier: "details") as!  DetailsViewController
        
        details.detailArray = recipes![indexPath.row]
        navigationController?.pushViewController(details, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        147
    }
}

extension UIImageView {
    func fetchImageFromUrl(_ url: String) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}
