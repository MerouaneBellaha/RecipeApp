//
//  RecipeCell.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 20/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var yield: UILabel!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var searchedIngredients: UILabel!
    @IBOutlet weak var coloredView: UIView!
    @IBOutlet weak var rightDetailImage: UIImageView!
    @IBOutlet weak var rightDetailText: UILabel!

    var recipe: RecipeModel? {
        didSet {
            guard let image = recipe?.image else {
                return picture.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            }
            picture.image = UIImage(data: image)

            yield.text = recipe?.yield
            recipeName.text = recipe?.name
            searchedIngredients.text = recipe?.searchedIngredients

            guard let options = recipe?.displayOptions else { return }
            rightDetailImage.image = UIImage(named: options.0)
            rightDetailText.text = options.1
            yield.isHidden = options.2
        }
    }

    var colorTheme: UIColor = #colorLiteral(red: 0.4549019608, green: 0.6235294118, blue: 0.4078431373, alpha: 1) {
        didSet {
            [yield, recipeName, searchedIngredients].forEach { label in
                label?.textColor = colorTheme
            }
            coloredView.backgroundColor = colorTheme
        }
    }
}
