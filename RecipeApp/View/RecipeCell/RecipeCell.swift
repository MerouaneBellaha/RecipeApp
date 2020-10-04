//
//  RecipeCell.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 20/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

final class RecipeCell: UITableViewCell {

    // MARK: - @IBOutlet Properties

    @IBOutlet private weak var picture: UIImageView!
    @IBOutlet private weak var yield: UILabel!
    @IBOutlet private weak var recipeName: UILabel!
    @IBOutlet private weak var ingredientsOverview: UILabel!
    @IBOutlet private weak var coloredView: UIView!
    @IBOutlet private weak var rightDetailImage: UIImageView!
    @IBOutlet private weak var rightDetailText: UILabel!

    // MARK: - Properties

    var recipe: RecipeViewModel? {
        didSet {
            setPicture(from: recipe?.pictureData)

            yield.text = recipe?.yield
            recipeName.text = recipe?.name
            ingredientsOverview.text = recipe?.ingredientsOverview

            setDisplayOptions(with: recipe?.displayOptions)
        }
    }

    var colorTheme: UIColor = #colorLiteral(red: 0.4549019608, green: 0.6235294118, blue: 0.4078431373, alpha: 1) {
        didSet {
            [yield, recipeName, ingredientsOverview]
                .forEach { $0?.textColor = colorTheme }
            coloredView.backgroundColor = colorTheme
        }
    }

    // MARK: - Methods

    // TODO: Add default picture if no Data
    private func setPicture(from: Data?) {
        guard let pictureData = recipe?.pictureData else {
            return picture.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        picture.image = UIImage(data: pictureData)
    }

    private func setDisplayOptions(with: (String, String?, Bool)?) {
        guard let options = recipe?.displayOptions else { return }
        rightDetailImage.image = UIImage(named: options.pictureName)
        rightDetailText.text = options.text
        yield.isHidden = options.isHidden
    }
}
