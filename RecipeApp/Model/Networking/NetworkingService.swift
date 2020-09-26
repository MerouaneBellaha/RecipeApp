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

    func request(ingredients: String, callback: @escaping (Result<EdamamData, RequestError>) -> Void) {

        guard let baseUrl = URL(string: "https://api.edamam.com/search?") else { return }

        var parameters = [("q", ingredients)]
        let keys = [("app_id", "297e5599"), ("app_key", "d1735c5df8f93d2d20c4849935735f5b")]
        let range = [("from", "0"), ("to", "10")]

        parameters.append(contentsOf: keys + range)

        let url = encode(baseUrl: baseUrl, with: parameters)
        print(url)
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
