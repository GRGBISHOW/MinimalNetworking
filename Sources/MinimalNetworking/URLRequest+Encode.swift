//
//  URLRequest+Encode.swift
//
//
//  Created by Bishow Gurung on 9/3/2024.
//

import Foundation

/// Extended URLRequest allowing to add httpbody
extension URLRequest {
    mutating func addBody(_ body: Encodable?) {
        guard let body = body else { return }
        let data = try? JSONEncoder().encode(body)
        self.httpBody = data
    }
}

/// Extended URL allowing to add query parameters
extension URL {
    mutating func addQueryItems(queryParams: [String: Any]?) {
        guard let queryParams = queryParams else {
            return
        }
        self.append(queryItems: queryParams.map({URLQueryItem(name: $0.key, value: "\($0.value)")}))
    }
}
