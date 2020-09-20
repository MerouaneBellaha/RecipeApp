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

    @IBAction private func clearButtonTapped(_ sender: UIButton) {
        fakeList.removeAll()
        tableView.reloadData()
    }

    @IBAction private func addButtonTapped(_ sender: UIButton) {
        guard textField.text != "",
            let ingredient = textField.text else {
                setAlertVc(with: "Aucun aliment à ajouter !")
                return
        }
        guard fakeList.count < 5 else {
            setAlertVc(with: "Pas plus de 5 ingrédients !")
            return
        }
        fakeList.append("• \(ingredient)")
        tableView.reloadData()
        textField.text?.removeAll()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fakeList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewFooterLabel.text = fakeList.count == 0 ? "add ingredients" : "Swipe left to remove an ingredient"
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
