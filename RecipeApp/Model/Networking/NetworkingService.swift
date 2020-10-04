//
//  NetworkingService.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 25/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

final class NetworkingService {

    // MARK: - Properties

    private let session: AlamoSession

    // MARK: - Init
    
    init(session: AlamoSession = NetworkingSession()) {
        self.session = session
    }

    // MARK: - Methods

    func request(ingredientsList: [String], callback: @escaping (Result<EdamamData, RequestError>) -> Void) {
        guard let baseUrl = Constant.EdamamAPI.baseURL else { return }
        let ingredients = ingredientsList.transformToString
        var parameters = [("q", ingredients)]
        parameters.append(contentsOf: EdamamKey.keys + Constant.EdamamAPI.range)
        let url = encode(baseUrl: baseUrl, with: parameters)

        session.request(with: url) { responseData in
            guard let data = responseData.data else {
                callback(.failure(.noData))
                return
            }
            guard responseData.response?.statusCode == 200 else {
                callback(.failure(.incorrectResponse))
                return
            }
            guard let responseDecoded = try? JSONDecoder().decode(EdamamData.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(responseDecoded))
        }
    }

    /// create URL from baseURL and paramaters tupple
    private func encode(baseUrl: URL, with parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false), let parameters = parameters, !parameters.isEmpty else { return baseUrl }
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let querryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(querryItem)
        }
        guard let url = urlComponents.url else { return baseUrl }
        return url
    }
}
