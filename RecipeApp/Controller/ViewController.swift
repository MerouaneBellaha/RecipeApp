//
//  ViewController.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 19/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

extension String {
    func transformToArray() -> [String] {
        return self.components(separatedBy: .punctuationCharacters)
            .map { $0.trimmingCharacters(in: .whitespaces)}
            .map { "🥕 \($0)"}
    }
}

extension Array where Element == String {
    func format() -> String {
        return self.map { $0.replacingOccurrences(of: "🥕 ", with: "") }
            .joined(separator: ",")
    }
}

import UIKit
//import Alamofire

final class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewFooterLabel: UILabel!
    @IBOutlet private weak var textField: CustomTextField!
    @IBOutlet private weak var tableViewHeaderLabel: UILabel!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var clearAllView: UIStackView!

    private var networkingService = NetworkingService()

    var fakeList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func clearButtonTapped() {
        fakeList.removeAll()
        tableView.reloadData()
    }

    @IBAction private func addButtonTapped() {
        guard textField.text != "",
              let ingredients = textField.text else {
            setAlertVc(with: "Aucun aliment à ajouter !")
            return
        }
        guard fakeList.count < 5 else {
            setAlertVc(with: "Vous ne pouvez pas ajouter plus d'ingrédients !")
            return
        }
        let ingredientsList = ingredients.transformToArray()
        fakeList.append(contentsOf: ingredientsList)
        tableView.reloadData()
        textField.text?.removeAll()
    }

    @IBAction private func searchButtonTapped() {

        let ingredients = fakeList.format()
        networkingService.request(ingredients: ingredients) { [unowned self] result in self.manageResult(with: result)
        }


    }

    private func navigateToRecipes(with data: EdamamData) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "recipesViewController") as! RecipesTableViewController
        nextViewController.recipesModel = data.hits.map { RecipeModel(hit: $0, query: data.q) }
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

    private func manageResult(with result: Result<EdamamData, RequestError>) {
        switch result {
        case .success(let data):
            DispatchQueue.main.async {
                guard !data.hits.isEmpty else {
                    return self.setAlertVc(with: "Au moins l'un de vos ingrédients n'existe pas, vérifiez l'orthrographe !")
                }
                self.navigateToRecipes(with: data)
            }
        case .failure(let error):
            setAlertVc(with: error.description)
        }
    }
}

struct RecipeModel {
    let hit: Hit
    let query: String

    var searchedIngredients: String { query.components(separatedBy: ",").joined(separator: ", ") }
    var name: String { hit.recipe.label }
    var image: String { hit.recipe.image }
    var yield: String { String(" \(hit.recipe.yield) parts") }
    var ingredients: [String] { hit.recipe.ingredientLines }
    var time: String { displayStringFormat(from: hit.recipe.totalTime) }



    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int) {
        print(hit.recipe.totalTime)

        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    func displayStringFormat(from seconds:Int) -> String {
        let (m, s) = secondsToHoursMinutesSeconds (seconds: seconds)
        return (m, s) == (0, 0) ? "N/A" : ("\(m)' \(s)''")
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fakeList.remove(at: indexPath.row)
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
        clearAllView.isHidden = fakeList.count == 0 ? true : false
        searchButton.isHidden = fakeList.count == 0 ? true : false
        tableViewFooterLabel.text = fakeList.count == 0 ? .none : "Swipe left to remove an ingredient"
        tableViewHeaderLabel.text = fakeList.count == 0 ? "Add some ingredients to start !" : "Your ingredients"
        return fakeList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        cell.textLabel?.text = fakeList[indexPath.row]
        return cell
    }
}

//extension String {
//    func format(from list: [String]) -> String {
//        list.joined(separator: ",")
//    }
//}

extension NSLayoutConstraint {

    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
