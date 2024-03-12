//
//  Requestable.swift
//  Networking
//
//  Created by Bishow Gurung on 19/2/2024.
//

import Combine
import Foundation

/// A type that can create request and dispatch itself
public protocol Requestable {
    associatedtype ResponseType: Decodable
    associatedtype RequestType: Encodable
    static var method: HTTPMethod { get }
    static var path : String { get }
    static var queryParams: [String: Any]? { get }
    static var headers: [String: String]? { get }
    static var host: APIHostable { get }
}

/// Some default implementation for Requestable
public extension Requestable {
    static var method: HTTPMethod { return .get }
    static var queryParams: [String: Any]? { return nil }
    static var headers: [String: String]? { return nil }
    static var session: URLSessionProtocol { NetworkService.urlSession() }
}
/// Some default implementation for Response and RequestType
public struct EmptyRequest: Encodable {}
public struct EmptyResponse: Decodable {}

/// A type that can inject BaseUrl
public protocol APIHostable {
    var baseUrl: String { get }
}

/// NeworkService Provider
public struct NetworkService {
    public static var urlSession: () -> URLSessionProtocol = {
        RequestHandler()
    }
}
