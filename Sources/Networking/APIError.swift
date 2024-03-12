//
//  APIError.swift
//  Networking
//
//  Created by Bishow Gurung on 19/2/2024.
//

import Foundation

public enum APIError: LocalizedError {
    case networkError(Error)
    case someThingWrong
    case invalidResponse
    case invalidRequest
    case validationError(String)
    
    public var errorDescription: String? {
        switch self {
        case .someThingWrong:
            return "Something went wrong"
        default:
            return "Some Error"
        }
    }
}
