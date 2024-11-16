//
//  HTTPMethod.swift
//  NyTimesApp
//
//  Created by Naveed Tahir on 16/11/2024.
//

import Foundation
// MARK: - HTTP METHODS Enum
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}


// MARK: - to get the request result success/failure
enum Result<T> {
    case success(T) // success result of type generic
    case failure(Error)
}
