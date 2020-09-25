//
//  Data.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 25/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

//struct ApiData: Decodable {
//    
//}

struct ApiData: Decodable {
    let main: Main
    let weather: [Weather]
    let name: String
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let description: String
}
