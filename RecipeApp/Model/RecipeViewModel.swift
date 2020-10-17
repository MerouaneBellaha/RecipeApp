//
//  RecipeModel.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 25/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

struct RecipeViewModel {

    // MARK: - Properties

    var name = ""
    var pictureData: Data? = nil
    var ingredientsOverview = ""
    var yield = ""
    var ingredients: [String] = []
    var cookingTime: String? = nil
    var displayOptions: (pictureName: String, text: String?, isHidden: Bool) {
        cookingTime == nil ?
            (Constant.ImageName.squares, yield, true) :
            (Constant.ImageName.stopwatch, cookingTime, false)
    }

    // MARK: - Init

    init(hit: Hit) {
        setProperties(name: hit.recipe.label,
                      data: hit.recipe.image.asData,
                      ingredients: hit.recipe.ingredientLines.joined(separator: ", "),
                      yield: "\(hit.recipe.yield) parts",
                      ingredientsList: hit.recipe.ingredientLines,
                      cookingtime: hit.recipe.totalTime == 0 ?
                        nil :
                        displayStringFormat(from: hit.recipe.totalTime)
        )
    }

    init(recipeEntity: RecipeEntity) {
        setProperties(name: recipeEntity.name ?? Constant.Text.emptyString,
                      data: recipeEntity.pictureData,
                      ingredients: recipeEntity.ingredientsOverview ?? Constant.Text.emptyString,
                      yield: recipeEntity.yield ?? Constant.Text.emptyString,
                      ingredientsList: recipeEntity.ingredientsList ?? [],
                      cookingtime: recipeEntity.cookingTime
        )
    }

    // MARK: - Methods

    mutating func setProperties(name: String,
                                data: Data?,
                                ingredients: String,
                                yield: String,
                                ingredientsList: [String],
                                cookingtime: String?) {
        self.name = name
        self.pictureData = data
        self.ingredientsOverview = ingredients
        self.yield = yield
        self.ingredients = ingredientsList
        self.cookingTime = cookingtime
    }

    /// convert time property from api into hours, minutes format
    private func minutesToHoursMinutes(minutes: Int) -> (Int, Int) {
        return (minutes / 60, (minutes % 60))
    }

    /// convert formatted time property to a displayable String
    private func displayStringFormat(from minutes: Int) -> String {
        let (h, m) = minutesToHoursMinutes(minutes: minutes)
        return h == 0 ? ("\(m)m") : ("\(h)h \(m)m")
    }
}
