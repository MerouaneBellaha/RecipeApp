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
        let colors = [#colorLiteral(red: 0.4723377824, green: 0.6867337227, blue: 0.4118994474, alpha: 1), #colorLiteral(red: 0.2952582538, green: 0.4324035943, blue: 0.7228902578, alpha: 1), #colorLiteral(red: 0.9382540584, green: 0.4337904453, blue: 0.2775209248, alpha: 1), #colorLiteral(red: 0.9272037148, green: 0.6851556301, blue: 0.370667696, alpha: 1)]
        return colors[step]
    }

    /// take a num and reduce it minus maxRange until this num is >= maxRange
    private static func reduce(_ num: Int, by maxRange: Int) -> Int {
        return num >= maxRange ? reduce(num-maxRange, by: maxRange) : num
    }
}
