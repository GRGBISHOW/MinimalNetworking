//
//  NetworkConfigurable.swift
//
//
//  Created by Bishow Gurung on 9/3/2024.
//

protocol NetworkConfigurable {
    associatedtype ErrorResponse: Decodable
    var APIHost: String { get }
}

