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
                      ingredientsList: recipeEntity.ingredientsOverview?
                        .components(separatedBy: ", ") ?? [],
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



//struct RecipeViewModel {
//    let hit: Hit
//
//    var ingredientsOverview: String { hit.recipe.ingredientLines.joined(separator: ", ") }
//    var name: String { hit.recipe.label }
//    var image: Data? { hit.recipe.image.asData }
//    var yield: String { String("\(hit.recipe.yield) parts") }
//    var ingredients: [String] { hit.recipe.ingredientLines }
//    var time: String? {
//        hit.recipe.totalTime == 0 ?
//            nil :
//            displayStringFormat(from: hit.recipe.totalTime)
//    }
//
//    var displayOptions: (String, String?, Bool) {
//        time == nil ?
//            ("square.split.2x2.fill", yield, true) :
//            ("stopwatch.fill", time, false)
//    }
//
//    private func minutesToHoursMinutes(minutes : Int) -> (Int, Int) {
//        return (minutes / 60, (minutes % 60))
//    }
//
//    private func displayStringFormat(from minutes:Int) -> String {
//        let (h, m) = minutesToHoursMinutes(minutes: minutes)
//        return h == 0 ? ("\(m)m") : ("\(h)h \(m)m")
//    }
//}


//struct RecipeViewModel {
//
//    let hit: Hit?
//    let recipeModel: RecipeModel?
//
//    init(hit: Hit? = nil, recipeModel: RecipeModel? = nil) {
//        self.hit = hit
//        self.recipeModel = recipeModel
//    }
//
//    var isFromRecipeModel: Bool {
//        recipeModel == nil ? false : true
//    }
//
//    var ingredientsOverview: String {
//        isFromRecipeModel ?
//            recipeModel?.ingredientsOverview ?? "" :
//            hit?.recipe.ingredientLines.joined(separator: ", ") ?? ""
//
//    }
//    var name: String {
//        isFromRecipeModel ?
//            recipeModel?.name ?? "" :
//            hit?.recipe.label ?? ""
//    }
//    var image: Data? {
//        isFromRecipeModel ?
//            recipeModel?.pictureData ?? nil :
//            hit!.recipe.image.asData ?? nil
//    }
//
//    var yield: String {
//        isFromRecipeModel ?
//            recipeModel?.yield ?? "" :
//            "\(hit?.recipe.yield ?? 0) parts"
//    }
//
//    var ingredients: [String] {
//        isFromRecipeModel ?
//            recipeModel?.ingredientsOverview?.components(separatedBy: ", ") ?? [] :
//            hit?.recipe.ingredientLines ?? []
//    }
//
//    var time: String? {
//        isFromRecipeModel ?
//            recipeModel?.time ?? nil :
//        hit?.recipe.totalTime == 0 ?
//            nil :
//            displayStringFormat(from: hit?.recipe.totalTime ?? 0)
//    }
//
//    var displayOptions: (String, String?, Bool) {
//        time == nil ?
//            ("square.split.2x2.fill", yield, true) :
//            ("stopwatch.fill", time, false)
//    }
//
//    private func minutesToHoursMinutes(minutes: Int) -> (Int, Int) {
//        return (minutes / 60, (minutes % 60))
//    }
//
//    private func displayStringFormat(from minutes: Int) -> String {
//        let (h, m) = minutesToHoursMinutes(minutes: minutes)
//        return h == 0 ? ("\(m)m") : ("\(h)h \(m)m")
//    }
//}
