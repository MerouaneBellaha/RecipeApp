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

            let options = setPresentationOption()
//            rightDetailImage.image = UIImage(systemName: options.0)
            rightDetailText.text = options.1
            yield.isHidden = options.2
        }
    }

    var colorTheme: UIColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) {
        didSet {
            [yield, recipeName, searchedIngredients].forEach { label in
                label?.textColor = colorTheme
            }
            coloredView.backgroundColor = colorTheme
        }
    }

    func setPresentationOption() -> (String, String?, Bool) {
        recipe?.time == nil ?
            ("square.split.2x2.fill", recipe?.yield, true) :
            ("stopwatch.fill", recipe?.time, false)
    }
}
