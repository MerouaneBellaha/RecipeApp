//
//  FavoriteButton.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 03/10/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

final class FavoriteButton: UIBarButtonItem {
    
    /// didSet: Change icon accordingly with isFavorite value
    var isFavorite: Bool = false {
        didSet {
            self.image = isFavorite ?
                UIImage(named: Constant.ImageName.starFill) :
                UIImage(named: Constant.ImageName.star)
        }
    }
}
