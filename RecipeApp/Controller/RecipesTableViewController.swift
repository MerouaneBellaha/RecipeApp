//
//  RecipesTableViewController.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 20/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    var recipesModel: [RecipeModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRecipeCell()
        
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
        nextViewController.recipeModel = recipesModel[indexPath.row]
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

}

