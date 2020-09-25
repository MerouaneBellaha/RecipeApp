//
//  RecipeModel.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 25/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

struct RecipeModel {
    let hit: Hit
    let query: String

    var searchedIngredients: String { query.components(separatedBy: ",").joined(separator: ", ") }
    var name: String { hit.recipe.label }
    var image: Data? { hit.recipe.image.asData }
    var yield: String { String(" \(hit.recipe.yield) parts") }
    var ingredients: [String] { hit.recipe.ingredientLines }
    var time: String { displayStringFormat(from: hit.recipe.totalTime) }

    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int) {
        print(hit.recipe.totalTime)

        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    func displayStringFormat(from seconds:Int) -> String {
        let (m, s) = secondsToHoursMinutesSeconds (seconds: seconds)
        return (m, s) == (0, 0) ? "N/A" : ("\(m)' \(s)''")
    }
}
