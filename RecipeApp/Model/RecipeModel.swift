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

    var searchedIngredients: String {
        query.components(separatedBy: ",")
            .joined(separator: ", ")
    }
    var name: String { hit.recipe.label }
    var image: Data? { hit.recipe.image.asData }
    var yield: String { String("\(hit.recipe.yield) parts") }
    var ingredients: [String] { hit.recipe.ingredientLines }
    var time: String? {
        hit.recipe.totalTime == 0 ?
            nil :
            displayStringFormat(from: hit.recipe.totalTime)
    }
    var displayOptions: (String, String?, Bool) {
        time == nil ?
            ("square.split.2x2.fill", yield, true) :
            ("stopwatch.fill", time, false)
    }
    
    private func minutesToHoursMinutes(minutes : Int) -> (Int, Int) {
        return (minutes / 60, (minutes % 60))
    }

    private func displayStringFormat(from minutes:Int) -> String {
        let (h, m) = minutesToHoursMinutes(minutes: minutes)
        return h == 0 ? ("\(m)m") : ("\(h)h \(m)m")
    }
}

