//
//  ArticleUseCase.swift
//  NyTimesApp
//
//  Created by Naveed Tahir on 16/11/2024.
//

import Foundation

protocol ArticleUseCase {
    func popularArticleListUseCase(completion: @escaping ((Result<ArticleListResponse>) -> ()))
}

class ArticleUseCaseImplementation : ArticleUseCase{
    
    let articleRepository: ArticleRepository
    
    init(repo: ArticleRepository) {
        self.articleRepository = repo
    }
    
    func popularArticleListUseCase(completion: @escaping ((Result<ArticleListResponse>) -> ())) {
        articleRepository.popularArticleList( completion: { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                if let response = UserInfoUtilities<ArticleListResponse>.loadModelFromUserDefaults(key: "articles").usersInfo {
                    completion(.success(response))
                    return
                }
                completion(.failure(error))
            }
        })
    }
}

    
    
