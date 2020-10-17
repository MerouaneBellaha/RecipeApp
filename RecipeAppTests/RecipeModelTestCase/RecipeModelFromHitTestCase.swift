//
//  RecipeModelFromHitTestCase.swift
//  RecipeAppTests
//
//  Created by Merouane Bellaha on 26/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import XCTest
@testable import RecipeApp

class RecipeModelFromHitTestCase: XCTestCase {

    var hit: Hit!
    var recipeModel: RecipeViewModel!

    override func setUpWithError() throws {
        hit = setUpDefaultHit(totalTime: 120, url: "https://www.edamam.com/")
        recipeModel = RecipeViewModel(hit: hit)
    }

    func testIngredientsOverviewValue() {
        let expectedResult = "Buy the carrot, Cook the carrot"

        XCTAssertEqual(recipeModel.ingredientsOverview, expectedResult)
    }

    func testNameValue() {
        let expectedResult = "Carrot Cake"

        XCTAssertEqual(recipeModel.name, expectedResult)
    }

    func testImageDataFormatting() {

        XCTAssertTrue((recipeModel?.pictureData) != nil)
        XCTAssertEqual(recipeModel.pictureData?.description, "43609 bytes")
    }

    func testYieldStringFormatting() {
        let expectedResult = "4 share"

        XCTAssertEqual(recipeModel.yield, expectedResult)
    }

    func testIngredientsValue() {
        let expectedResult = [
            "Buy the carrot",
            "Cook the carrot",
          ]

        XCTAssertEqual(recipeModel.ingredients, expectedResult)
    }

    func testTimeStringFormattingWhenTimeIsNot0() {
        let expectedResult = "2h 0m"

        XCTAssertEqual(recipeModel.cookingTime, expectedResult)
    }

    func testTimeStringFormattingWhenTimeIsMinuteOnly() {
        recipeModel = RecipeViewModel(hit: setUpDefaultHit(totalTime: 10, url: nil))

        let expectedResult = "10m"

        XCTAssertEqual(recipeModel.cookingTime, expectedResult)
    }

    func testTimeStringFormattingWhenTimeIs0() {
        recipeModel = RecipeViewModel(hit: setUpDefaultHit(totalTime: 0, url: nil))


        let expectedResult: String? = nil
        XCTAssertEqual(recipeModel.cookingTime, expectedResult)
    }

    func testDisplayOptionsTupleFormattingWhenTimeIsNotNil() {
        let expectedResult = ("stopwatch.fill", recipeModel.cookingTime, false)

        XCTAssertEqual(recipeModel.displayOptions.0, expectedResult.0)
        XCTAssertEqual(recipeModel.displayOptions.1, expectedResult.1)
        XCTAssertEqual(recipeModel.displayOptions.2, expectedResult.2)
    }

    func testDisplayOptionsTupleFormattingWhenTimeIstNil() {
        recipeModel = RecipeViewModel(hit: setUpDefaultHit(totalTime: 0, url: nil))

        let expectedResult = ("square.split.2x2.fill", recipeModel.yield, true)

        XCTAssertEqual(recipeModel.displayOptions.0, expectedResult.0)
        XCTAssertEqual(recipeModel.displayOptions.1, expectedResult.1)
        XCTAssertEqual(recipeModel.displayOptions.2, expectedResult.2)
    }

    func testUrlValue() {
        let expectedResult = "https://www.edamam.com/"

        XCTAssertEqual(recipeModel.url, expectedResult)
    }

    func testNilUrlValue() {
        recipeModel = RecipeViewModel(hit: setUpDefaultHit(totalTime: 0, url: nil))

        XCTAssertEqual(recipeModel.url, Constant.Text.emptyString)
    }

    private func setUpDefaultHit(totalTime: Int, url: String?) -> Hit {
        return Hit(recipe: Recipe(label: "Carrot Cake",
                                  image: "https://www.edamam.com/web-img/6b6/6b6d059217d67cb9b454edd6cded1144.JPG",
                                  yield: 4,
                                  url: url,
                                  ingredientLines: [
                                    "Buy the carrot",
                                    "Cook the carrot",
                                  ],
                                  totalTime: totalTime))
    }

    override func tearDownWithError() throws {
        hit = nil
        recipeModel = nil
    }
}
