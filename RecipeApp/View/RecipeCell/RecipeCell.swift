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
    @IBOutlet weak var time: UILabel!

    var recipe: RecipeModel? {
        didSet {
            yield.text = recipe?.yield
            recipeName.text = recipe?.name
            searchedIngredients.text = recipe?.searchedIngredients
            time.text = recipe?.time
            guard let data = recipe?.image.data else {
                picture.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                return
            }
            picture.image = UIImage(data: data)
        }
    }
}


extension String {
    /// get data from URL
    var data: Data? {
        guard let url = URL(string: self) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
}
