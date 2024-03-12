//
//  Requestable.swift
//  Networking
//
//  Created by Bishow Gurung on 19/2/2024.
//

import Combine
import Foundation

public protocol Requestable {
    associatedtype Response: Decodable
    associatedtype Request: Encodable
    associatedtype ErrorResponse: ErrorCodable
    static var method: HTTPMethod { get }
    static var path : String { get }
    static var host: APIHostable { get }
    static var handler: URLSessionProtocol { get }
}

public protocol HandlerInjectable {
    var handler: URLSessionProtocol { get }
}

public protocol APIHostable {
    var baseurl: String { get set }
}

public protocol ErrorCodable: Decodable {
    var code: String { get }
}

extension URLRequest {
    mutating func encode(_ body: Encodable?) {
        guard let body = body else { return }
        let data = try? JSONEncoder().encode(body)
        self.httpBody = data
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

extension Requestable {
    
    private static func makeRequest(_ body: Request?) -> URLRequest? {
        guard let url = URL(string: host.baseurl+path) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = 60
        urlRequest.encode(body)
        return urlRequest
        
    }
    
    public static func load(withRequestBody body: Request? = nil) -> AnyPublisher<Response, APIError>{
        guard let request = makeRequest(body) else {
            return Fail(error: .invalidRequest).eraseToAnyPublisher()
        }
        return handler
            .response(request: request)
            .mapError { error in
                return APIError.networkError(error)
            }
            .tryMap { (data, response) -> (data: Data, response: URLResponse) in
                guard let urlResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                
                if !(200..<300).contains(urlResponse.statusCode)  {
                    let decoder = JSONDecoder()
                    let apiError = try decoder.decode(ErrorResponse.self, from: data)
                    throw APIError.validationError(apiError.code)
                }
                return (data, response)
            }
            .map {$0.0}
            .decode(type: Response.self, decoder: JSONDecoder())
            .catch { error in
                return Fail<Response, APIError>(error: error as? APIError ?? .someThingWrong).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
