//
//  RecipeDetailViewController.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 26/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

final class RecipeDetailViewController: UIViewController {

    // MARK: - @IBOutlet properties

    @IBOutlet private weak var background: UIView!
    @IBOutlet private weak var recipeImage: UIImageView!
    @IBOutlet private weak var cookingTimeLabel: UILabel!
    @IBOutlet private weak var yieldsLabel: UILabel!
    @IBOutlet private weak var favoriteButton: FavoriteButton!

    // MARK: - Properties

    var coreDataManager: CoreDataManager?
    var recipeViewModel: RecipeViewModel!
    var colorTheme: UIColor = #colorLiteral(red: 0.4549019608, green: 0.6235294118, blue: 0.4078431373, alpha: 1)
    var isFromFavorites: Bool = false

    // MARK: - View lifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setCoreDataManager()
        setUIProperties()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarColor(with: colorTheme)
        setFavoriteButton()
        popViewControllerIfNecessary()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ok")
        setNavigationBarColor(with: #colorLiteral(red: 0.4549019608, green: 0.6235294118, blue: 0.4078431373, alpha: 1))
    }

    // MARK: - @IBAction methods

    @IBAction func favoriteButtonTapped(_ sender: FavoriteButton) {
        sender.isFavorite ?
            coreDataManager?.deleteFavorite(named: recipeViewModel.name) :
            coreDataManager?.createFavorite(from: recipeViewModel)
        sender.isFavorite.toggle()
        popViewControllerIfNecessary()
    }

    // MARK: - Methods

    private func popViewControllerIfNecessary() {
        guard favoriteButton.isFavorite == false,
             isFromFavorites == true else {
            return
        }
        navigationController?.popViewController(animated: true)
    }

    private func setCoreDataManager() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataManager = CoreDataManager(with: appDelegate.coreDataStack)
    }

    private func setFavoriteButton() {
        coreDataManager?.containsFavorite(named: recipeViewModel.name) == true ?
            (favoriteButton.isFavorite = true) :
            (favoriteButton.isFavorite = false)
    }

    private func setUIProperties() {
        guard let pictureData = recipeViewModel.pictureData else {
            return recipeImage.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        recipeImage.image = UIImage(data: pictureData)
        title = recipeViewModel.name
        background.backgroundColor = colorTheme
        cookingTimeLabel.text = recipeViewModel.cookingTime == nil ?
            Constant.Text.emptyString : "cooking time : \(recipeViewModel.cookingTime ?? Constant.Text.NA)"
        yieldsLabel.text = recipeViewModel.yield
    }

    private func setNavigationBarColor(with color: UIColor) {
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: color]
        navigationController?.navigationBar.tintColor = color
    }
}

// MARK: - UITableViewDataSource

extension RecipeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeViewModel.ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.ingredientDetailCell, for: indexPath)
        cell.textLabel?.text = recipeViewModel.ingredients[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension RecipeDetailViewController: UITableViewDelegate {

}
