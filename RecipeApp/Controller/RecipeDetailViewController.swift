//
//  RecipeDetailViewController.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 26/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

final class RecipeDetailViewController: UIViewController {

    @IBOutlet private weak var background: UIView!
    @IBOutlet private weak var recipeImage: UIImageView!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    @IBOutlet weak var yieldsLabel: UILabel!

    var coreDataManager: CoreDataManager?
    var recipeModel: RecipeModel!
    var colorTheme: UIColor = #colorLiteral(red: 0.4549019608, green: 0.6235294118, blue: 0.4078431373, alpha: 1)


    override func viewDidLoad() {
        super.viewDidLoad()
        title = recipeModel.name
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: colorTheme]

        guard let image = recipeModel.image else {
            return recipeImage.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        recipeImage.image = UIImage(data: image)

        background.backgroundColor = colorTheme

        cookingTimeLabel.text = recipeModel.time == nil ? "" : "cooking time : \(recipeModel.time ?? "N/A")"
        yieldsLabel.text = recipeModel.yield


        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataManager = CoreDataManager(with: appDelegate.coreDataStack)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.4549019608, green: 0.6235294118, blue: 0.4078431373, alpha: 1)]
    }

    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
//        sender.image = UIImage(named: "")
    }
}

extension RecipeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeModel.ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientDetailCell", for: indexPath)
        cell.textLabel?.text = recipeModel.ingredients[indexPath.row]
        return cell
    }
}

extension RecipeDetailViewController: UITableViewDelegate {

}
