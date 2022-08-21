//
//  RecipeListCell.swift
//  FoodRecipe
//
//  Created by Mohamed Shibl on 19/08/2022.
//

import UIKit

class RecipeListCell: UITableViewCell {

    // MARK: - outlets
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var recipeHealthLabels: UILabel!
    @IBOutlet weak var cellContainer: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setViewProperties()
    }
    
    func setViewProperties() {
        
        cellContainer.layer.shadowOffset = CGSize(width: 10,
                                          height: 10)
        cellContainer.layer.shadowRadius = 8
        cellContainer.layer.shadowOpacity = 0.3
        
        cellContainer.backgroundColor = UIColor.white
        cellContainer.layer.borderColor = UIColor.gray.cgColor
        cellContainer.layer.borderWidth = 0.1
        cellContainer.layer.cornerRadius = 8
        cellContainer.clipsToBounds = true
    }
}
