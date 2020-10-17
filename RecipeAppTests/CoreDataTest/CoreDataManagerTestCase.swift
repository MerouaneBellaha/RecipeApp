//
//  CoreDataManagerTestCase.swift
//  RecipeAppTests
//
//  Created by Merouane Bellaha on 17/10/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import XCTest
@testable import RecipeApp

class CoreDataManagerTestCase: XCTestCase {

    var coreDataStack: CoreDataStack!
    var coreDataManager: CoreDataManager!
    var recipeViewModel: RecipeViewModel!

    override func setUp() {
        super.setUp()
        coreDataStack = FakeCoreDataStack()
        coreDataManager = CoreDataManager(with: coreDataStack)
        recipeViewModel = setUpDefaultRecipeViewModel(named: "Carrot Cake")
    }

    func testGivenContextIsEmpty_WhenAddingAFavorite_ThenContextShouldHaveOneFavorite() {
        coreDataManager.addFavorite(from: recipeViewModel)

        XCTAssertTrue(coreDataManager.loadFavorites().count == 1)
        XCTAssertTrue(coreDataManager.loadFavorites().first?.name == "Carrot Cake")
    }

    func testGiventContextIsEmpty_WhenAddingAFavoriteThenRemovingThisFavorite_ThenContextShouldBeEmpty() {
        coreDataManager.addFavorite(from: recipeViewModel)

        coreDataManager.deleteFavorite(named: "Carrot Cake")

        XCTAssertTrue(coreDataManager.loadFavorites().count == 0)
    }

    func testGivenContextContainsFewFavorites_WhenLoadingWithPredicate_ThenContextShouldReturnOnlyPredicateRecipeEntityFavorite() {
        addMultipleFavorites()

        XCTAssertEqual(coreDataManager.loadFavorites(with: "Carrot Cake").first?.name, "Carrot Cake")
        XCTAssertTrue(coreDataManager.loadFavorites(with: "Carrot Cake").count == 1)
    }

    func testGivenContextContainsCarrotCakeRecipeEntity_WhenCheckingIfContextContainsCarrotCakeRecipeEntity_ThenResultShouldBeTrue() {
        addMultipleFavorites()

        XCTAssertTrue(coreDataManager.isContainingFavorite(named: "Carrot Cake"))
    }

    func testGiventContextDoesntContainCheeseCakeRecipeEntity_WhenCheckingIfContextContainsCheeseCakeRecipeEntity_ThenResultShouldBeFalse() {
        addMultipleFavorites()

        XCTAssertFalse(coreDataManager.isContainingFavorite(named: "CheeseCake"))
    }

    private func setUpDefaultRecipeViewModel(named name: String) -> RecipeViewModel {
        return RecipeViewModel(
            hit: Hit(recipe: Recipe(label: name,
                                    image:"",
                                    yield: 4,
                                    url: "",
                                    ingredientLines: [],
                                    totalTime: 0)
            )
        )
    }

    private func addMultipleFavorites() {
        coreDataManager.addFavorite(from: recipeViewModel)
        coreDataManager.addFavorite(from: setUpDefaultRecipeViewModel(named: "Chicken nuggets"))
        coreDataManager.addFavorite(from: setUpDefaultRecipeViewModel(named: "Chicken curry"))
    }

    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        coreDataManager = nil
    }
}
