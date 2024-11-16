//
//  ArticleRepositoryImplementation.swift
//  NyTimesApp
//
//  Created by Naveed Tahir on 16/11/2024.
//

class ArticleRepositoryImplementation: ArticleRepository {
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
   
    func popularArticleList(completion: @escaping ((Result<ArticleListResponse>) -> ())) {
        networkService.sendRequest(url: ArticleEndPoints.ArticleListing.url!, headerValue: RequestHeaders.getDefaultHeaders(), for: ArticleListResponse.self) { result in
            switch result {
            case .success(let data):
                UserInfoUtilities<ArticleListResponse>.saveModelInUserDefaults(key: "articles", userInfo: data)
                completion(.success(data))
          
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
