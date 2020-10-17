//
//  RecipeModelFromRecipeEntityTestCase.swift
//  RecipeAppTests
//
//  Created by Merouane Bellaha on 17/10/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import XCTest
@testable import RecipeApp

class RecipeModelFromRecipeEntityTestCase: XCTestCase {

    var recipeEntity: RecipeEntity!
    var recipeModel: RecipeViewModel!
    var coreDataStack: CoreDataStack!

    override func setUpWithError() throws {
        coreDataStack = FakeCoreDataStack()
        recipeEntity = setUpDefaultRecipeEntity()
        recipeModel = RecipeViewModel(recipeEntity: recipeEntity)
    }

    func testRecipeNameSringValue() {
        let expectedResult = "Carrot Cake"

        XCTAssertEqual(recipeModel.name, expectedResult)
    }

    func testPictureDataFormatting() {

        XCTAssertTrue((recipeModel?.pictureData) != nil)
        XCTAssertEqual(recipeModel.pictureData?.description, "43609 bytes")
    }

    func testIngredientsOverviewValue() {
        let expectedResult = "carrot, ham"

        XCTAssertEqual(recipeModel.ingredientsOverview, expectedResult)
    }

    func testYieldValue() {
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

    func testCookingTimeValue() {
        let expectedResult = "1h 10m"

        XCTAssertEqual(recipeModel.cookingTime, expectedResult)
    }

    func testUrlValue() {
        let expectedResult = "https://www.edamam.com/"

        XCTAssertEqual(recipeModel.url, expectedResult)
    }

    func testRecipeEntityValuesWhenNil() {
        recipeEntity = setUpDefaultRecipeEntityWithNilValues()
        recipeModel = RecipeViewModel(recipeEntity: recipeEntity)

        XCTAssertEqual(recipeModel.name, Constant.Text.emptyString)
        XCTAssertEqual(recipeModel.ingredientsOverview, Constant.Text.emptyString)
        XCTAssertEqual(recipeModel.yield, Constant.Text.emptyString)
        XCTAssertEqual(recipeModel.ingredients, [])
        XCTAssertEqual(recipeModel.url, Constant.Text.emptyString)
    }

    private func setUpDefaultRecipeEntity() -> RecipeEntity {
        let recipeEntity = RecipeEntity(context: coreDataStack.context)
        recipeEntity.name = "Carrot Cake"
        recipeEntity.pictureData = "https://www.edamam.com/web-img/6b6/6b6d059217d67cb9b454edd6cded1144.JPG".asData
        recipeEntity.ingredientsOverview = "carrot, ham"
        recipeEntity.yield = "4 share"
        recipeEntity.ingredientsList = [
            "Buy the carrot",
            "Cook the carrot",
          ]
        recipeEntity.cookingTime = "1h 10m"
        recipeEntity.url = "https://www.edamam.com/"
        return recipeEntity
    }

    private func setUpDefaultRecipeEntityWithNilValues() -> RecipeEntity {
        let recipeEntity = RecipeEntity(context: coreDataStack.context)
        recipeEntity.name = nil
        recipeEntity.ingredientsOverview = nil
        recipeEntity.yield = nil
        recipeEntity.ingredientsList = nil
        recipeEntity.url = nil
        return recipeEntity
    }

    override func tearDownWithError() throws {
        recipeEntity = nil
        recipeModel = nil
    }
}
