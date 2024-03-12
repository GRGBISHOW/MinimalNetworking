//
//  APIError.swift
//  Networking
//
//  Created by Bishow Gurung on 19/2/2024.
//

import Foundation

/// Network Error, a Wrapper to encapsulate all local and api errors
public enum NetworkError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case apiError(Int)
    case serverError
    case decodingError(String)
    case urlSessionFailed(URLError)
    case unknownError
}

extension Requestable {
    
    /// Handles error with status code and returns respective error
    /// - Parameter statusCode: Int
    /// - Returns: NetworkError
    static func httpError(_ statusCode: Int ) -> NetworkError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .apiError(statusCode)
        case 500: return .serverError
        default: return .unknownError
        }
    }
    
    /// Handles Error and returns NetworkError
    /// - Parameter error: Error
    /// - Returns: NetworkError
    static func handleError(_ error: Error) -> NetworkError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError(error.localizedDescription)
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as NetworkError:
            return error
        default:
            return .unknownError
        }
    }
}
