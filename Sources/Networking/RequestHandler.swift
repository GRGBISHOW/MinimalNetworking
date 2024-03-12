//
//  RequestHandler.swift
//  Networking
//
//  Created by Bishow Gurung on 19/2/2024.
//

import Combine
import Foundation

public protocol URLSessionProtocol {
    typealias APIResponse = URLSession.DataTaskPublisher.Output
    func response(request: URLRequest) -> AnyPublisher<APIResponse, URLError>
}
 
struct RequestHandler: URLSessionProtocol {
    func response(request: URLRequest) -> AnyPublisher<APIResponse, URLError> {
        URLSession.shared.dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}
