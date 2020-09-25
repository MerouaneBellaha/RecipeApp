//
//  ViewController.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 19/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

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

        networkingService.request(ingredients: String()) { [unowned self] result in self.manageResult(with: result)
        }

    }

    @IBAction private func clearButtonTapped() {
        fakeList.removeAll()
        tableView.reloadData()
    }

    @IBAction private func addButtonTapped() {
        guard textField.text != "",
              let ingredient = textField.text else {
            setAlertVc(with: "Aucun aliment à ajouter !")
            return
        }
        guard fakeList.count < 5 else {
            setAlertVc(with: "Pas plus de 5 ingrédients !")
            return
        }
        fakeList.append("🥕 \(ingredient)")
        tableView.reloadData()
        textField.text?.removeAll()
    }

    @IBAction private func searchButtonTapped() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "recipesViewController") as! RecipesTableViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

    private func manageResult(with result: Result<ApiData, RequestError>) {
        switch result {
        case .success(let data):
            DispatchQueue.main.async {
                print(data)
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
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

extension NSLayoutConstraint {

    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
