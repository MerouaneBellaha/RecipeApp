//
//  Constant.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 04/10/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

struct Constant {

    struct Identifier {
        static let storyboardName = "Main"
        static let recipesVC = "recipesViewController"
        static let recipeDetailsVC = "RecipeDetailViewController"
        static let ingredientCell = "ingredientCell"
        static let recipeCellNib = "RecipeCell"
        static let recipeCell = "recipeCell"
        static let ingredientDetailCell = "ingredientDetailCell"
    }

    struct EdamamAPI {
        static let baseURL = URL(string: "https://api.edamam.com/search?")
        static let range: [(String, String)] = [("from", "0"), ("to", "10")]
    }

    struct ErrorDescription {
        static let noData = "Can't reach the server, please retry."
        static let incorrectResponse = "Incorrect response"
        static let undecodableData = "Undecodable data"
    }

    struct ImageName {
        static let squares = "square.split.2x2.fill"
        static let stopwatch = "stopwatch.fill"
        static let noPhoto = "noPhoto"
        static let star = "star"
        static let starFill = "star.fill"
    }

    struct ColorName {
        static let accent = "Accent"
    }

    struct Text {
        static let emptyString = ""
        static let noFoodToAdd = "No food to add !\nPlease add some to continue..."
        static let cantAddMoreFood = "You can't add more food !\nRemove some to add more..."
        static let wait = "Please wait !"
        static let gettingRecipes = "We're getting your recipes !"
        static let foodDoesntExist = "At least one your food doesn't exist.\nPlease check your spelling..."
        static let swipeToRemove = "Swipe left to remove an ingredient"
        static let addFood = "Add some ingredients to start !"
        static let yourFood = "Your ingredients"
        static let delete = "Delete"
        static let NA = "N/A"
        static let noDetails = "There's no details for this recipe. Sorry !"
    }
}
