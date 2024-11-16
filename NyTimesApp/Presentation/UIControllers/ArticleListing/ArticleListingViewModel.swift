//
//  Untitled.swift
//  NyTimesApp
//
//  Created by Naveed Tahir on 16/11/2024.
//

import Foundation

class ArticleListingViewModel {
    // MARK: - PROPERTIES
    var errorMessage: Observable<String?> = Observable(nil)
    
    var responseData: Observable<ArticleListResponse> = Observable(nil)
    
    var useCase : ArticleUseCase?
    
    init(useCase : ArticleUseCase){
        self.useCase  = useCase
    }
    
    // MARK: - FUNCTIONS
    func getPopularArticleList(){
        useCase?.popularArticleListUseCase(completion: { result in
            switch result{
            case .success(let data):
                self.responseData.property = data
            case .failure(let error):
                self.setError(error.localizedDescription)
            }
        })
    }
    
    private func setError(_ message: String) {
        self.errorMessage.property = message
    }
}
