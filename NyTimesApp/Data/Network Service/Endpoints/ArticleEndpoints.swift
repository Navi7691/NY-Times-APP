//
//  ArticleEndpoints.swift
//  NyTimesApp
//
//  Created by Naveed Tahir on 16/11/2024.
//

import Foundation


enum ArticleEndPoints: CaseIterable {
    // MARK: User actions
    case ArticleListing
}


extension ArticleEndPoints: EndPoint {
       var baseURL: String {
           return Constants.baseUrl
       }
       
       var path: String {
           switch self {
           case .ArticleListing:
               return "emailed/7.json?api-key=\(Constants.articleKey)"
           }
       }
       
       var httpMethod: HTTPMethod {
           switch self {
           case .ArticleListing:
               return .get
           }
       }
       
       var url: URL? {
           switch self {
           case .ArticleListing:
               return URL(string: Constants.baseUrl + self.path)!
           }
       }
}
