//
//  RequestError.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 25/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case noData, incorrectResponse, undecodableData

    var description: String {
        switch self {
        case .noData:
            return Constant.ErrorDescription.noData
        case .incorrectResponse:
            return Constant.ErrorDescription.incorrectResponse
        case .undecodableData:
            return Constant.ErrorDescription.undecodableData
        }
    }
}
