//
//  NetworkService.swift
//  NyTimesApp
//
//  Created by Naveed Tahir on 16/11/2024.
//

import Foundation
import UIKit

protocol NetworkService {
    func sendRequest<T: Decodable, U: Codable>(url: URL, body: U, headerValue: [String:String], for type: T.Type, completion: @escaping (Result<T>) -> Void)
    
    func sendRequest<T: Codable>(url: URL, headerValue: [String:String], for type: T.Type, completion: @escaping (Result<T>) -> Void)
}


class LiveNetworkService : NetworkService{

    // MARK: - BASIC PROPERTIES
    /// Used when the endpoint requires a header-type (i.e. "content-type") be specified in the header
    enum HeaderContentType: String {
        case contentType = "Content-Type"
    }

    /// Used to switch between live and Mock Data
    /// in object-oriented programming, mock objects are simulated objects that mimic the behavior of real objects in controlled ways, most often as part of a software testing initiative.
    var networkClient: NYTimesNetworkClient

    //MARK: - INEJCTION OF URLSESSION OBJECT
    init(networkClient: NYTimesNetworkClient = URLSession.shared) {
        self.networkClient = networkClient
    }

    // MARK: - CREATE API REQUEST
    /// Creating a request with URL and requestMethod
    func createRequest( url: URL?, method: HTTPMethod, headerType: HeaderContentType? = nil, headerValue: [String: String]) -> URLRequest? {
        guard let requestUrl = url else {
            return nil
        }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headerValue
        return request
    }

  
    
    // MARK: - GENERIC FUNCTION FOR POST REQUEST
    //using <> placeholder type for generics
    public func sendRequest<T: Decodable, U: Codable>(url:URL, body: U,headerValue: [String:String] ,for: T.Type = T.self, completion: @escaping (Result<T>) -> Void) {
        
        guard let request = self.createRequest(url: url, method: .post, headerType: .contentType, headerValue: headerValue) else { print("Error Creating Request. Nil URL?")
            return
        }
        var req = request
        req = encode(from: body, request: request)!
        
        self.networkClient.loadData(using: req) { (data, response, error) in
            guard let data = data else {
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            let responseData = decode(to: T.self, data: data)
            completion(.success(responseData!))
        }
    }

    public func sendRequest<T: Codable>(url:URL,headerValue: [String:String] ,for: T.Type = T.self, completion: @escaping (Result<T>) -> Void) {
        
        guard let request = self.createRequest(url: url, method: .get, headerValue: headerValue)
        else { print("Error Creating Request. Nil URL?")
            return
        }
        
        self.networkClient.loadData(using: request) { (data, response, error) in
            guard let data = data else {
                completion(.failure(CustomError.message(error?.localizedDescription ?? "no data found") as Error))
                return
            }
            let list = decode(to: T.self, data: data)
            completion(.success(list!))
        }
    }
}


class MockNetworkService : NetworkService{
    var shouldReturnError = false
    
    func sendRequest<T, U>(url: URL, body: U, headerValue: [String : String], for type: T.Type, completion: @escaping (Result<T>) -> Void) where T : Decodable, U : Decodable, U : Encodable {
        
    }
    
    public func sendRequest<T: Codable>(url:URL,headerValue: [String:String] ,for: T.Type = T.self, completion: @escaping (Result<T>) -> Void) {
        let mockError = NSError(domain: "com.example.error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock network error"])
        
        if url.absoluteString == "https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=\(Constants.articleKey)" {
            if shouldReturnError{
                completion(.failure(mockError))
                return
            }
            let jsonString = """
                 {
                   "status": "OK",
                   "copyright": "Copyright (c) 2024 The New York Times Company.  All Rights Reserved.",
                   "num_results": 20,
                   "results": [
                     {
                       "uri": "nyt://article/02241405-a46e-5af3-b08a-666b2b263aa7",
                       "url": "https://www.nytimes.com/2024/11/12/opinion/trump-had-it-easy-the-first-time.html",
                       "id": 100000009820924,
                       "asset_id": 100000009820924,
                       "source": "New York Times",
                       "published_date": "2024-11-12",
                       "updated": "2024-11-13 17:43:30",
                       "section": "Opinion",
                       "subsection": "",
                       "nytdsection": "opinion",
                       "adx_keywords": "United States International Relations;Israel-Gaza War (2023- );United States Politics and Government;Defense and Military Forces;Russian Invasion of Ukraine (2022);Nuclear Weapons;Protectionism (Trade);Arms Control and Limitation and Disarmament;Presidential Transition (US);Putin, Vladimir V;Netanyahu, Benjamin;Trump, Donald J;China;Iran;Israel;Russia;Ukraine",
                       "column": null,
                       "byline": "By Thomas L. Friedman",
                       "type": "Article",
                       "title": "Trump Had It Easy the First Time",
                       "abstract": "A host of problems that will need more subtle and sophisticated uses of force and coercive diplomacy will confront the new president.",
                       "des_facet": [
                         "United States International Relations",
                         "Israel-Gaza War (2023- )",
                         "United States Politics and Government",
                         "Defense and Military Forces",
                         "Russian Invasion of Ukraine (2022)",
                         "Nuclear Weapons",
                         "Protectionism (Trade)",
                         "Arms Control and Limitation and Disarmament",
                         "Presidential Transition (US)"
                       ],
                       "org_facet": [
                         
                       ],
                       "per_facet": [
                         "Putin, Vladimir V",
                         "Netanyahu, Benjamin",
                         "Trump, Donald J"
                       ],
                       "geo_facet": [
                         "China",
                         "Iran",
                         "Israel",
                         "Russia",
                         "Ukraine"
                       ],
                       "media": [
                         {
                           "type": "image",
                           "subtype": "photo",
                           "caption": "",
                           "copyright": "Daniel Ribar for The New York Times",
                           "approved_for_syndication": 1,
                           "media-metadata": [
                             {
                               "url": "https://static01.nyt.com/images/2024/11/13/multimedia/12Friedman-czgw/12Friedman-czgw-thumbStandard.jpg",
                               "format": "Standard Thumbnail",
                               "height": 75,
                               "width": 75
                             },
                             {
                               "url": "https://static01.nyt.com/images/2024/11/13/multimedia/12Friedman-czgw/12Friedman-czgw-mediumThreeByTwo210.jpg",
                               "format": "mediumThreeByTwo210",
                               "height": 140,
                               "width": 210
                             },
                             {
                               "url": "https://static01.nyt.com/images/2024/11/13/multimedia/12Friedman-czgw/12Friedman-czgw-mediumThreeByTwo440.jpg",
                               "format": "mediumThreeByTwo440",
                               "height": 293,
                               "width": 440
                             }
                           ]
                         }
                       ],
                       "eta_id": 0
                     },
                     
                   ]
                 }
                 """
            
            if let jsonData = jsonString.data(using: .utf8) {
                if let list = decode(to: T.self, data: jsonData) {
                    completion(.success(list))
                }else{
                    completion(.failure(CustomError.message("Response Data Is Incorrect") as Error))
                }
            }
            
            //            guard let data = data else {
            //                completion(.failure(CustomError.message(error?.localizedDescription ?? "no data found") as Error))
            //                return
            //            }
            //
        }else{
            completion(.failure(CustomError.message("URL Is Incorrect") as Error))
        }
    }
}


// MARK: - GENERIC DECODE FUNCTION TO DECODE DATA
func decode<T: Decodable>(to type: T.Type, data: Data) -> T? {
    let decoder = JSONDecoder()
    do {
        return try decoder.decode(T.self, from: data)
    } catch {
        print("Error Decoding JSON into \(String(describing: type)) Object \(error)")
        return nil
    }
}

// MARK: - GENERIC ENCODE FUCNTION TO ENCODE DATA
func encode<T: Encodable>(from instance: T, request: URLRequest) -> URLRequest? {
    let jsonEncoder = JSONEncoder()
    var request = request
    do {
        request.httpBody = try jsonEncoder.encode(instance)
        return request
    } catch {
        print("Error encoding object into JSON \(error)")
        return nil
    }
}

enum CustomError: Error {
    case message(String)
}
