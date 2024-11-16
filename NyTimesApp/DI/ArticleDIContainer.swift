//
//  ArticleDI.swift
//  NyTimesApp
//
//  Created by Naveed Tahir on 16/11/2024.
//


import Foundation

final class ArticleDIContainer {
    
    // MARK: - View model
    func articleListingViewModel() -> ArticleListingViewModel{
        return ArticleListingViewModel(useCase: articleUseCase())
    }
   
    // MARK: - UseCases
    private func articleUseCase() -> ArticleUseCase {
        return ArticleUseCaseImplementation(repo: articlesRepository())
    }
    
  
    // MARK: - Repository
    private func articlesRepository() -> ArticleRepository {
        return ArticleRepositoryImplementation(networkService: LiveNetworkService())
    }
}
