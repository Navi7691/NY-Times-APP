//
//  ArticleRepository.swift
//  NyTimesApp
//
//  Created by Naveed Tahir on 16/11/2024.
//

import Foundation

protocol ArticleRepository {
    func popularArticleList(completion: @escaping ((Result<ArticleListResponse>) -> ()))
}
