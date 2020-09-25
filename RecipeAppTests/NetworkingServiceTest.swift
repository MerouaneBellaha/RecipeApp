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
    var requestResult: (ApiData?, Error?)

    // setup

//    func testRequestShouldPostFailureIfError() {
//        performRequest(data: nil, response: nil, error: FakeResponseData.error)
//        testRequestResult(description: "Error")
//    }

//    func testRequestShouldPostFailureIfError() {
//        performRequest(data: nil, response: nil, error: FakeResponseData.error)
//        testRequestResult(description: "Can't reach the server, please retry.")
//    }

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
        networkingService.request(ingredients: "") { self.manageResult(with: $0) }
//        let URLSession = URLSessionFake(data: data, response: response, error: error)
//        httpClient = HTTPClient(httpEngine: HTTPEngine(session: URLSession))
//        httpClient.request(baseUrl: K.baseURLweather) { self.manageResult(with: $0) }
    }

    private func testRequestResult(description: String) {
        XCTAssertNil(requestResult.0)
        XCTAssertNotNil(requestResult.1)
        XCTAssertEqual((requestResult.1 as! RequestError).description, description)
    }

    private func testRetrivedData() {
        let id = 804
        let description = "overcast clouds"
        let temp = 19.11
        let name = "London"

        XCTAssertEqual(requestResult.0?.weather.first?.id, id)
        XCTAssertEqual(requestResult.0?.weather.first?.description, description)
        XCTAssertEqual(requestResult.0?.main.temp, temp)
        XCTAssertEqual(requestResult.0?.name, name)
    }

    private func manageResult(with result: Result<ApiData, RequestError>) {
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
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
