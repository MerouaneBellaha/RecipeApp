//
//  RecipesTableViewController.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 20/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    var recipesModel: [RecipeModel] = [] { didSet { tableView.reloadData() }}

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRecipeCell()



        let hit = Hit(recipe: Recipe(label: "Carrot Cake",
                                     image: "https://www.edamam.com/web-img/6b6/6b6d059217d67cb9b454edd6cded1144.JPG",
                                     yield: 4,
                                     ingredientLines: [
                                        "Buy the carrot",
                                        "Cook the carrot",
                                     ],
                                     totalTime: 120)
        )

        guard recipesModel.isEmpty else { return }
        title = "Your recipes"
        recipesModel.append(RecipeModel(hit: hit, query: "jambon"))
        recipesModel.append(RecipeModel(hit: hit, query: "jambon"))
        recipesModel.append(RecipeModel(hit: hit, query: "jambon"))
        
    }

    private func setUpRecipeCell() {
        let cellNib = UINib(nibName: "RecipeCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "recipeCell")
    }

    // MARK: - TableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeCell
        cell.colorTheme = UIColor().getColorTheme(from: indexPath.row)
        cell.recipe = recipesModel[indexPath.row]
        cell.selectionStyle = .none
        return cell

    }

    // MARK: - TableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as! RecipeDetailViewController
        nextViewController.colorTheme = (tableView.cellForRow(at: indexPath) as! RecipeCell).colorTheme
        nextViewController.recipeModel = recipesModel[indexPath.row]
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

}

