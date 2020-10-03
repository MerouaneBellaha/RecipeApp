//
//  UIColor+getColorTheme.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 26/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

extension UIColor {
    static func getColorTheme(from index: Int) -> UIColor {
        let step = reduce(index, by: 4)
        let colors = [#colorLiteral(red: 0.4500253201, green: 0.627276659, blue: 0.3985392451, alpha: 1), #colorLiteral(red: 0.2005394399, green: 0.3820231557, blue: 0.7559244037, alpha: 1), #colorLiteral(red: 0.9382540584, green: 0.4337904453, blue: 0.2775209248, alpha: 1), #colorLiteral(red: 1, green: 0.7285203338, blue: 0.3738058209, alpha: 1)]
        return colors[step]
    }

    private static func reduce(_ num: Int, by maxRange: Int) -> Int {
        return num >= maxRange ? reduce(num-maxRange, by: maxRange) : num
    }
}
