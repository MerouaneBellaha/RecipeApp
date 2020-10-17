//
//  String+transformToArray.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 25/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

extension String {

    /// take a String, separate elements by .punctuationCharacters in a [String], remove .whitepaces and add "🥕 " in front for each elements
    var transformToArray: [String] {
        return self.components(separatedBy: .punctuationCharacters)
            .filter { $0 != "" }
            .map { $0.trimmingCharacters(in: .whitespaces)}
            .map { "🥕 \($0)"}
    }
}

