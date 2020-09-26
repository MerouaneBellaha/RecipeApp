//
//  RecipeAppTests.swift
//  RecipeAppTests
//
//  Created by Merouane Bellaha on 25/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import XCTest
@testable import RecipeApp

class NetworkingServiceTest: XCTestCase {

    var networkingService: NetworkingService!
    var requestResult: (EdamamData?, Error?)

    func testRequestShouldPostFailureIfNoData() {
        performRequest(data: nil, response: nil, error: nil)
        testRequestResult(description: "Can't reach the server, please retry.")
    }

    func testRequestShouldPostFailureIfIncorrestResponse() {
        performRequest(data: FakeResponseData.recipeCorrectData, response: FakeResponseData.responseKO, error: nil)
        testRequestResult(description: "Incorrect response")
    }

    func testRequestShouldPostFailureIfIncorrectData() {
        performRequest(data: FakeResponseData.recipeIncorrectData, response: FakeResponseData.responseOK, error: nil)
        testRequestResult(description: "Undecodable data")
    }

    func testRequestShouldPostSuccessIfNoErrorAndCorrectData() {
        performRequest(data: FakeResponseData.recipeCorrectData, response: FakeResponseData.responseOK, error: nil)

        XCTAssertNotNil(requestResult.0)
        XCTAssertNil(requestResult.1)

        testRetrivedData()
    }

    private func performRequest(data: Foundation.Data?, response: HTTPURLResponse?, error: Error?) {
        let session = MockNetworkingSession(fakeResponse: FakeResponse(response: response, data: data))
        networkingService = NetworkingService(session: session)
        networkingService.request(ingredients: "") { [unowned self] result in
            self.manageResult(with: result)
        }
    }

    private func testRequestResult(description: String) {
        XCTAssertNil(requestResult.0)
        XCTAssertNotNil(requestResult.1)
        XCTAssertEqual((requestResult.1 as! RequestError).description, description)
    }

    private func testRetrivedData() {
        let query = "carrot"
        let recipeLabel = "Carrot Cake"
        let imageURL = "https://imageURL"
        let yield = 4
        let cookingInstruction = ["Buy the carrot",
                                  "Cook the carot"]
        let totalTime = 120

        XCTAssertEqual(requestResult.0?.q, query)
        XCTAssertEqual(requestResult.0?.hits[0].recipe.label, recipeLabel)
        XCTAssertEqual(requestResult.0?.hits[0].recipe.image, imageURL)
        XCTAssertEqual(requestResult.0?.hits[0].recipe.yield, yield)
        XCTAssertEqual(requestResult.0?.hits[0].recipe.ingredientLines, cookingInstruction)
        XCTAssertEqual(requestResult.0?.hits[0].recipe.totalTime, totalTime)
    }

    private func manageResult(with result: Result<EdamamData, RequestError>) {
        switch result {
        case .failure(let error):
            requestResult = (nil, error)
        case .success(let data):
            requestResult = (data, nil)
        }
    }

    override func tearDown() {
        super.tearDown()
        networkingService = nil
        requestResult = (nil, nil)
    }
}
