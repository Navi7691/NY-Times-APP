
struct RequestHeaders {
    
    static var defaultHeaders: [String: String] = getDefaultHeaders()
    
    static func getDefaultHeaders() -> [String: String] {
        // Add your default headers here
        let headers: [String:String] = [
            "Content-Type": "application/json"
        ]
        return headers
    }
    
    static func requestHeadersForMovieDetails () -> [String: String] {
        // Add your default headers here
        let headers: [String:String] = [
            "Content-Type": "application/json",
            "append_to_response": "videos,credits"
        ]
        return headers
    }
}
