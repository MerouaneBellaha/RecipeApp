//
//  ViewController.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 19/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - @IBOutler Properties

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewFooterLabel: UILabel!
    @IBOutlet private weak var textField: CustomTextField!
    @IBOutlet private weak var tableViewHeaderLabel: UILabel!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var clearButton: UIStackView!

    // MARK: - Properties

    private var networkingService = NetworkingService()
    private var loader: UIAlertController!

    var ingredients: [String] = []

    // MARK: - @IBAction methods

    @IBAction private func clearButtonTapped() {
        ingredients.removeAll()
        tableView.reloadData()
    }

    @IBAction private func addButtonTapped() {
        guard textField.text != Constant.Text.emptyString,
              let ingredients = textField.text else {
            setAlertVc(with: Constant.Text.noFoodToAdd)
            return
        }
        guard self.ingredients.count < 5 else {
            setAlertVc(with: Constant.Text.cantAddMoreFood)
            return
        }
        let ingredientsList = ingredients.transformToArray
        self.ingredients.append(contentsOf: ingredientsList)
        tableView.reloadData()
        textField.text?.removeAll()
    }

    @IBAction private func searchButtonTapped() {
        setActivityAlert(withTitle: Constant.Text.wait,
                         message: Constant.Text.gettingRecipes) { loader in
            self.networkingService.request(ingredientsList: self.ingredients) { [unowned self] result in
                self.manageResult(with: result)
            }
            self.loader = loader
        }
    }

    // MARK: - Methods

    private func navigateToRecipes(with data: EdamamData) {
        let storyBoard: UIStoryboard = UIStoryboard(name: Constant.Identifier.storyboardName, bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: Constant.Identifier.recipesVC) as! RecipesTableViewController
        nextViewController.recipesViewModels = data.hits.map { RecipeViewModel(hit: $0) }
        navigationController?.pushViewController(nextViewController, animated: true)
        loader.dismiss(animated: false)
    }

    private func manageResult(with result: Result<EdamamData, RequestError>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                guard !data.hits.isEmpty else {
                    self.loader.dismiss(animated: true)
                    return self.setAlertVc(with: Constant.Text.foodDoesntExist)
                }
                self.navigateToRecipes(with: data)
            case .failure(let error):
                self.loader.dismiss(animated: true)
                self.setAlertVc(with: error.description)
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: Constant.Text.delete) { _, indexPath in
            self.tableView.dataSource?.tableView?(self.tableView, commit: .delete, forRowAt: indexPath)
        }
        deleteButton.backgroundColor = UIColor(named: Constant.ColorName.accent)
        return [deleteButton]
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        clearButton.isHidden = ingredients.count == 0 ? true : false
        searchButton.isHidden = ingredients.count == 0 ? true : false
        tableViewFooterLabel.text = ingredients.count == 0 ? .none : Constant.Text.swipeToRemove
        tableViewHeaderLabel.text = ingredients.count == 0 ?
            Constant.Text.addFood : Constant.Text.yourFood
        return ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.ingredientCell, for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
}
