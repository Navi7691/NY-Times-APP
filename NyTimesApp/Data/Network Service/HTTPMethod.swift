
import Foundation
// MARK: - HTTP METHODS Enum
enum HTTPMethod: String {
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}


// MARK: - to get the request result success/failure
enum Result<T> {
    case success(T) // success result of type generic
    case failure(Error)
}
