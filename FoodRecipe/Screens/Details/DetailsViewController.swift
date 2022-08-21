//
//  DetailsViewController.swift
//  FoodRecipe
//
//  Created by Mohamed Shibl on 20/08/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeIngredients: UITextView!
    
    
    var detailArray: Hit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shareBT = UIBarButtonItem()
        shareBT.action = #selector(share)
        if #available(iOS 13.0, *) {
            shareBT.image = UIImage(systemName: "square.and.arrow.up")
            
        } else {
            
        }
        shareBT.target = self
        navigationItem.rightBarButtonItem = shareBT
        
        recipeTitle.text = detailArray?.recipe?.label
        recipeImage.fetchImageFromUrl((detailArray?.recipe?.image)!)
        
        textingingredients()
        
    }
    
    
    @IBAction func openRecipeWebsite(_ sender: Any) {
        guard let website = detailArray?.recipe?.url else { return  }
        if let url=URL(string: website){
            UIApplication.shared.open(url)
        }
    }
    
    @objc func share() {
        guard let shareUrlString = detailArray?.recipe?.shareAs else { return  } //"http://www.edamam.com/recipe/chicken-vesuvio-b79327d05b8e5b838ad6cfd9576b30b6/chicken/low-carb"
        let url = URL(string: shareUrlString)!
        let activity = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activity, animated: true)
    }
    
    private func textingingredients() {
        
        for i in 0..<detailArray!.recipe!.ingredientLines.count {
            
            let integarte = detailArray!.recipe!.ingredientLines[i]
            recipeIngredients.text! += "\(i+1)) " + integarte + "\n"
            
            }
        
        
//
//        var i = 0
//        var str: String = ""
//        let timer = Timer()
//        str += "\(detailArray!.recipe!.ingredients![i]) \n"
//
//          recipeIngredients.text = str
//
//
//        if i == ((detailArray?.recipe?.ingredients?.count)!) - 1 {
//            timer.invalidate()
//        }
//        i += 1
    }
    
    
}
