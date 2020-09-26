//
//  RecipeDetailViewController.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 26/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var recipeModel: RecipeModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = recipeModel.name
    }

}
