//
//  RecipesTableViewController.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 20/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

final class RecipesTableViewController: UITableViewController {

    // MARK: - Properties

    var recipesViewModels: [RecipeViewModel] = [] { didSet { tableView.reloadData() }}

    // MARK: - View lifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRecipeCell()
    }

    // MARK: - Methods

    private func setUpRecipeCell() {
        let cellNib = UINib(nibName: Constant.Identifier.recipeCellNib, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: Constant.Identifier.recipeCell)
    }

    // MARK: - TableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesViewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.recipeCell, for: indexPath) as! RecipeCell
        cell.colorTheme = .getColorTheme(from: indexPath.row)
        cell.recipe = recipesViewModels[indexPath.row]
        cell.selectionStyle = .none
        return cell

    }

    // MARK: - TableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: Constant.Identifier.storyboardName, bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: Constant.Identifier.recipeDetailsVC) as! RecipeDetailViewController
        nextViewController.colorTheme = (tableView.cellForRow(at: indexPath) as! RecipeCell).colorTheme
        nextViewController.recipeViewModel = recipesViewModels[indexPath.row]
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

