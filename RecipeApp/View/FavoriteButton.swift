//
//  FavoriteButton.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 03/10/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

final class FavoriteButton: UIBarButtonItem {
    var isFavorite: Bool = false {
        didSet {
            self.image = isFavorite ?
                UIImage(named: "square.split.2x2.fill") :
                UIImage(named: "stopwatch.fill")
        }
    }

//    override var image: UIImage? {
//            isFavorite ?
//                (image = UIImage(named: "square.split.2x2.fill")) :
//                (image = UIImage(named: "stopwatch.fill"))
//    }
}
