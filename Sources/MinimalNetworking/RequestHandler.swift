//
//  RequestHandler.swift
//  Networking
//
//  Created by Bishow Gurung on 19/2/2024.
//

import Combine
import Foundation

/// A type representing an session and response value that can be generated.
public protocol URLSessionProtocol {
    typealias APIResponse = URLSession.DataTaskPublisher.Output
    func response(request: URLRequest) -> AnyPublisher<APIResponse, URLError>
}

/// A default implementation of URLSessionProtocol to provide session and  response
struct RequestHandler: URLSessionProtocol {
    func response(request: URLRequest) -> AnyPublisher<APIResponse, URLError> {
        URLSession.shared.dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}

