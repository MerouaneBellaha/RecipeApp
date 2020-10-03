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
    @IBOutlet weak var favoriteButton: FavoriteButton!

    var coreDataManager: CoreDataManager?
    var recipeViewModel: RecipeViewModel!
    var colorTheme: UIColor = #colorLiteral(red: 0.4549019608, green: 0.6235294118, blue: 0.4078431373, alpha: 1)
    var isFromFavorites: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataManager = CoreDataManager(with: appDelegate.coreDataStack)

        coreDataManager?.containsFavorite(named: recipeViewModel.name) == true ?
            (favoriteButton.isFavorite = true) :
            (favoriteButton.isFavorite = false)




        title = recipeViewModel.name
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: colorTheme]

        guard let image = recipeViewModel.image else {
            return recipeImage.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        recipeImage.image = UIImage(data: image)

        background.backgroundColor = colorTheme

        cookingTimeLabel.text = recipeViewModel.time == nil ? "" : "cooking time : \(recipeViewModel.time ?? "N/A")"
        yieldsLabel.text = recipeViewModel.yield
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.4549019608, green: 0.6235294118, blue: 0.4078431373, alpha: 1)]
    }

    @IBAction func favoriteButtonTapped(_ sender: FavoriteButton) {
        sender.isFavorite ?
            coreDataManager?.deleteFavorite(named: recipeViewModel.name) :
            coreDataManager?.createFavorite(from: recipeViewModel)
        sender.isFavorite.toggle()


        print(coreDataManager?.loadFavorites().count)
//
        guard sender.isFavorite == false,
             isFromFavorites == true else {
            print("là")
            return
        }
        print("ici")
        navigationController?.popViewController(animated: true)
//        if (parent as? FavoriteRecipesTableViewController) != nil {
//            navigationController?.popViewController(animated: true)
//        }

//        if sender.isFavorite == false { navigationController?.popViewController(animated: true) }






//        coreDataManager?.createItem(callBack: { [self] recipe in
//            recipe.ingredientsOverview  = recipeViewModel.ingredientsOverview
//            recipe.name = recipeViewModel.name
//            recipe.pictureData = recipeViewModel.image
//            recipe.time = recipeViewModel.time
//            recipe.yield = recipeViewModel.yield
//        })
    }
}

extension RecipeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeViewModel.ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientDetailCell", for: indexPath)
        cell.textLabel?.text = recipeViewModel.ingredients[indexPath.row]
        return cell
    }
}

extension RecipeDetailViewController: UITableViewDelegate {

}
