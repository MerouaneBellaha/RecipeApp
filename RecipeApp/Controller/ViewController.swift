//
//  ViewController.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 19/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewFooterLabel: UILabel!
    @IBOutlet private weak var textField: CustomTextField!
    @IBOutlet private weak var tableViewHeaderLabel: UILabel!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var clearAllView: UIStackView!

    private var networkingService = NetworkingService()
    private var activityIndicator: UIAlertController!

    var ingredients: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func clearButtonTapped() {
        ingredients.removeAll()
        tableView.reloadData()
    }

    @IBAction private func addButtonTapped() {
        guard textField.text != "",
              let ingredients = textField.text else {
            setAlertVc(with: "Aucun aliment à ajouter !")
            return
        }
        guard self.ingredients.count < 5 else {
            setAlertVc(with: "Vous ne pouvez pas ajouter plus d'ingrédients !")
            return
        }
        let ingredientsList = ingredients.transformToArray()
        self.ingredients.append(contentsOf: ingredientsList)
        tableView.reloadData()
        textField.text?.removeAll()
    }

    @IBAction private func searchButtonTapped() {
        let ingredients = self.ingredients.transformToString()
        setActivityAlert(withTitle: "Please wait !",
                         message: "We're getting your recipes !")
        { activityIndicator in
            self.networkingService.request(ingredients: ingredients) { [unowned self] result in self.manageResult(with: result)
            }
            self.activityIndicator = activityIndicator
        }

    }

    private func navigateToRecipes(with data: EdamamData) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "recipesViewController") as! RecipesTableViewController
        nextViewController.recipesModel = data.hits.map { RecipeModel(hit: $0, query: data.q) }
        self.navigationController?.pushViewController(nextViewController, animated: true)
        activityIndicator.dismiss(animated: false)
    }

    private func manageResult(with result: Result<EdamamData, RequestError>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                guard !data.hits.isEmpty else {
                    self.activityIndicator.dismiss(animated: true)
                    return self.setAlertVc(with: "Au moins l'un de vos ingrédients n'existe pas, vérifiez l'orthrographe !")
                }
                self.navigateToRecipes(with: data)
            case .failure(let error):
                self.activityIndicator.dismiss(animated: true)
                self.setAlertVc(with: error.description)
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "Delete") { _, indexPath in
            self.tableView.dataSource?.tableView?(self.tableView, commit: .delete, forRowAt: indexPath)
        }
        deleteButton.backgroundColor = UIColor(named: "Accent")
        return [deleteButton]
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        clearAllView.isHidden = ingredients.count == 0 ? true : false
        searchButton.isHidden = ingredients.count == 0 ? true : false
        tableViewFooterLabel.text = ingredients.count == 0 ? .none : "Swipe left to remove an ingredient"
        tableViewHeaderLabel.text = ingredients.count == 0 ? "Add some ingredients to start !" : "Your ingredients"
        return ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
}

extension NSLayoutConstraint {

    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
