//
//  RequestHeaders.swift
//  NyTimesApp
//
//  Created by Naveed Tahir on 16/11/2024.
//

struct RequestHeaders {
    
    static var defaultHeaders: [String: String] = getDefaultHeaders()
    
    static func getDefaultHeaders() -> [String: String] {
        // Add your default headers here
        let headers: [String:String] = [
            "Content-Type": "application/json"
        ]
        return headers
    }
}
