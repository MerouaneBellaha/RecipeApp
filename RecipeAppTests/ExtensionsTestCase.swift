//
//  ExtensionsTestCase.swift
//  RecipeAppTests
//
//  Created by Merouane Bellaha on 17/10/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import XCTest
@testable import RecipeApp

class ExtensionsTestCase: XCTestCase {

    let array = ["🥕 carrot", "🥕 ham", "🥕 cheese"]

    func testTransformToArrayComputedProperty() {
        let stringToTransform = "carrot,, ham :    cheese"
        let result = stringToTransform.transformToArray

        XCTAssertEqual(array, result)
    }

    func testTransformToStringComputedProperty() {
        let result = array.transformToString
        let expectedResult = "carrot,ham,cheese"

        XCTAssertEqual(result, expectedResult)
    }

    func testAsDataComputedPropertyOnLegitStringUrl() {
        let result = "https://www.edamam.com/web-img/6b6/6b6d059217d67cb9b454edd6cded1144.JPG".asData

        XCTAssertEqual("43609 bytes", result?.description)
        XCTAssertNotNil(result)
    }

    func testAsDataComputedPropertyOnFailingStringUrl() {
        let result = "failingStringUrl".asData

        XCTAssertNil(result)
    }
}
