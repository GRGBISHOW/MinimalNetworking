//
//  HTTPMethod.swift
//
//
//  Created by Bishow Gurung on 10/3/2024.
//


/// HTTPMethods
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

/// Some defined headerfields
enum HTTPHeaderField: String {
    case authentication = "Authentication"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case authorization = "Authorization"
}

enum ContentType: String {
    case json = "application/json"
}
