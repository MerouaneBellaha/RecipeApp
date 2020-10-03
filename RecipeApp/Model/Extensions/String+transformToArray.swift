//
//  String+transformToArray.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 25/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

extension String {
    func transformToArray() -> [String] {
        return self.components(separatedBy: .punctuationCharacters)
            .map { $0.trimmingCharacters(in: .whitespaces)}
            .map { "🥕 \($0)"}
    }

    var test: [String] {
        return self.components(separatedBy: .punctuationCharacters)
            .map { $0.trimmingCharacters(in: .whitespaces)}
            .map { "🥕 \($0)"}
    }
}
