//
//  FavoriteRecipesTableViewController.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 20/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

final class FavoriteRecipesTableViewController: UITableViewController {

    // MARK: - Properties

    private var recipesViewModels: [RecipeViewModel] = [] { didSet { tableView.reloadData() }}
    private var coreDataManager: CoreDataManager?

    // MARK: - View lifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRecipeCell()
        setCoreDataManager()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipesViewModels = coreDataManager?.loadFavorites().map { RecipeViewModel(recipeEntity: $0) } ?? []
    }

    // MARK: - Methods

    private func setUpRecipeCell() {
        let cellNib = UINib(nibName: "RecipeCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "recipeCell")
    }

    private func setCoreDataManager() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataManager = CoreDataManager(with: appDelegate.coreDataStack)
    }

    // MARK: - TableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesViewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeCell
        cell.colorTheme = .getColorTheme(from: indexPath.row)
        cell.recipe = recipesViewModels[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }

    // MARK: - TableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as! RecipeDetailViewController
        nextViewController.colorTheme = (tableView.cellForRow(at: indexPath) as! RecipeCell).colorTheme
        nextViewController.recipeViewModel = recipesViewModels[indexPath.row]
        nextViewController.isFromFavorites = true
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

