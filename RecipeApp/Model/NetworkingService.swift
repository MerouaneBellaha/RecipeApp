//
//  NetworkingService.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 25/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

final class NetworkingService {

    private let session: AlamoSession
    
    init(session: AlamoSession = NetworkingSession()) {
        self.session = session
    }

    func request(ingredients: String, callback: @escaping (Result<ApiData, RequestError>) -> Void) {

        guard let baseUrl = URL(string: "https://api.edamam.com/search?") else { return }

        //        let parameters = apikey + ingredients ?

//        let url = encode(baseUrl: baseUrl, with: parameters)

        let url = encode(baseUrl: baseUrl, with: [(String, Any)]())

        session.request(with: url) { responseData in
            guard let data = responseData.data else {
                callback(.failure(.noData))
                return
            }

            guard responseData.response?.statusCode == 200 else {
                callback(.failure(.incorrectResponse))
                return
            }

            guard let responseDecoded = try? JSONDecoder().decode(ApiData.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }

            callback(.success(responseDecoded))
        }
    }

    /// Encoding
    /// - Parameters:
    ///   - baseUrl: Without any parameters
    ///   - parameters: Differents api provide by API
    /// - Returns: Final complete url
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
