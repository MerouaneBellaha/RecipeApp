//
//  FakeResponseData.swift
//  travelAppTests
//
//  Created by Merouane Bellaha on 24/07/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

class FakeResponseData {

    // MARK: - Data

    static var recipeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let recipeIncorrectData = "erreur".data(using: .utf8)! //

    // MARK: - Response
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
}
