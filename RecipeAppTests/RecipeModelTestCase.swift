//
//  RecipeModelTestCase.swift
//  RecipeAppTests
//
//  Created by Merouane Bellaha on 26/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import XCTest
@testable import RecipeApp

class RecipeModelTestCase: XCTestCase {

    var hit: Hit!
    var recipeModel: RecipeModel!

    override func setUpWithError() throws {
        hit = setUpDefaultHit(totalTime: 120)
        recipeModel = RecipeModel(hit: hit, query: "carrot,pistache")
    }

    func testSearchedIngredientsStringFormatting() {
        let expectedResult = "carrot, pistache"

        XCTAssertEqual(recipeModel.searchedIngredients, expectedResult)
    }

    func testNameStringFormatting() {
        let expectedResult = "Carrot Cake"

        XCTAssertEqual(recipeModel.name, expectedResult)
    }

    func testImageDataFormatting() {

        XCTAssertTrue((recipeModel?.image) != nil)
        XCTAssertEqual(recipeModel.image?.description, "43609 bytes")
    }

    func testYieldStringFormatting() {
        let expectedResult = "4 parts"

        XCTAssertEqual(recipeModel.yield, expectedResult)
    }

    func testIngredientsStringFormatting() {
        let expectedResult = [
            "Buy the carrot",
            "Cook the carrot",
          ]

        XCTAssertEqual(recipeModel.ingredients, expectedResult)
    }

    func testTimeStringFormattingWhenTimeIsNot0() {
        let expectedResult = "2 h 0 m"

        XCTAssertEqual(recipeModel.time, expectedResult)
    }

    func testTimeStringFormattingWhenTimeIs0() {
        recipeModel = RecipeModel(hit: setUpDefaultHit(totalTime: 0), query: "")

        let expectedResult: String? = nil

        XCTAssertEqual(recipeModel.time, expectedResult)
    }

    func testDisplayOptionsTupleFormattingWhenTimeIsNotNil() {
        let expectedResult = ("stopwatch.fill", recipeModel.time, false)

        XCTAssertEqual(recipeModel.displayOptions.0, expectedResult.0)
        XCTAssertEqual(recipeModel.displayOptions.1, expectedResult.1)
        XCTAssertEqual(recipeModel.displayOptions.2, expectedResult.2)
    }

    func testDisplayOptionsTupleFormattingWhenTimeIstNil() {
        recipeModel = RecipeModel(hit: setUpDefaultHit(totalTime: 0), query: "")

        let expectedResult = ("square.split.2x2.fill", recipeModel.yield, true)

        XCTAssertEqual(recipeModel.displayOptions.0, expectedResult.0)
        XCTAssertEqual(recipeModel.displayOptions.1, expectedResult.1)
        XCTAssertEqual(recipeModel.displayOptions.2, expectedResult.2)
    }

    private func setUpDefaultHit(totalTime: Int) -> Hit {
        return Hit(recipe: Recipe(label: "Carrot Cake",
                                  image: "https://www.edamam.com/web-img/6b6/6b6d059217d67cb9b454edd6cded1144.JPG",
                                  yield: 4,
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

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}