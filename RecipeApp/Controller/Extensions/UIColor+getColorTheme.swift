//
//  UIColor+getColorTheme.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 26/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

extension UIColor {

    /// get a UIColor accordingly to the index
    static func getColorTheme(from index: Int) -> UIColor {
        let step = reduce(index, by: 4)
        let colors = [#colorLiteral(red: 0.4705882353, green: 0.6862745098, blue: 0.4117647059, alpha: 1), #colorLiteral(red: 0.2952582538, green: 0.4324035943, blue: 0.7228902578, alpha: 1), #colorLiteral(red: 0.937254902, green: 0.4352941176, blue: 0.2784313725, alpha: 1), #colorLiteral(red: 0.9254901961, green: 0.6862745098, blue: 0.3725490196, alpha: 1)]
        return colors[step]
    }

    /// take a num and reduce it minus maxRange until this num is >= maxRange
    private static func reduce(_ num: Int, by maxRange: Int) -> Int {
        return num >= maxRange ? reduce(num-maxRange, by: maxRange) : num
    }
}
