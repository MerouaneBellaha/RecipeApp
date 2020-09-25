//
//  MockNetworkingSession.swift
//  RecipeAppTests
//
//  Created by Merouane Bellaha on 25/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

@testable import RecipeApp
import Foundation
import Alamofire

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Foundation.Data?
//    var error: Error?
}

final class MockNetworkingSession: AlamoSession {

    private let fakeResponse: FakeResponse

    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }

    func request(with url: URL, callback: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
//        let error = fakeResponse.error
        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: nil)
        let urlRequest = URLRequest(url: URL(string: "https://api.edamam.com")!)
        callback(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
}
