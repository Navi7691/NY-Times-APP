//
//  NyTimesAppTests.swift
//  NyTimesAppTests
//
//  Created by Naveed Tahir on 16/11/2024.
//

import XCTest
@testable import NyTimesApp

final class NyTimesAppTests: XCTestCase {

    var repo:  ArticleRepository!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        repo = ArticleRepositoryImplementation(networkService: MockNetworkService())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_getPopularArticles_Success() throws {
        let expectation = self.expectation(description: "Response is successful")
        
        repo.popularArticleList(completion: { result in
            switch result {
            case .success(let articleList):
                XCTAssertNotNil(articleList.results, "Articles list should not be nil")
                XCTAssertFalse(articleList.results!.isEmpty, "Articles list should not be empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success but got failure with error: \(error.localizedDescription)")
            }
        })
        
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getPopularArticles_Failure() throws {
        let expectation = self.expectation(description: "Response is expected to fail")
        let mockService = MockNetworkService()
        mockService.shouldReturnError = true
        repo = ArticleRepositoryImplementation(networkService: mockService)
        
        repo.popularArticleList(completion: { result in
            switch result {
            case .success(let articleList):
                XCTFail("Expected failure but got success with: \(articleList.results ?? [])")
                
            case .failure(let error):
                XCTAssertNotNil(error, "Error should not be nil")
                print("Received expected error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
}
