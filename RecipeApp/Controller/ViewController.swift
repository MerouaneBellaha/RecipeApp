//
//  ViewController.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 19/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit
import Alamofire

final class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewFooterLabel: UILabel!
    @IBOutlet private weak var textField: CustomTextField!
    @IBOutlet private weak var tableViewHeaderLabel: UILabel!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var clearAllView: UIStackView!

    var fakeList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        AF.request("https://api.androidhive.info/contacts/")
            .response { response in


                guard response.error == nil else {
                    debugPrint(response.error.debugDescription)
                    return }

                guard let data = response.data else { return }
                
                guard let dataDecoded = try? JSONDecoder().decode(Data.self, from: data) else { return }
                debugPrint(dataDecoded)
        }
    }

    @IBAction func clearButtonTapped() {
        fakeList.removeAll()
        tableView.reloadData()
    }

    @IBAction func addButtonTapped() {
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
//        tableViewFooterLabel.text = fakeList.count == 0 ? "add ingredients" : "Swipe left to remove an ingredient"
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

struct Data: Decodable {
    var contacts: [UserInfo]

    struct UserInfo: Decodable {
        var name: String
    }
}


extension NSLayoutConstraint {

    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
