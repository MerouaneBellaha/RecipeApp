//
//  Array+transformToString.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 25/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

extension Array where Element == String {

    /// Take a [String], remove occurences of 🥕, and join it separated by ","
    var transformToString: String {
        return self.map { $0.replacingOccurrences(of: "🥕 ", with: "") }
            .joined(separator: ",")
    }
}
