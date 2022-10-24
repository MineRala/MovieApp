//
//  DetailViewModelTests.swift
//  MovieAppTests
//
//  Created by Mine Rala on 24.10.2022.
//

import XCTest
@testable import MovieApp

final class DetailViewModelTests: XCTestCase {
    private var viewModel: DetailViewModel!
    private var view: MockDetailViewController!
    
    override func setUp() {
        super.setUp()
        view = .init()
        viewModel = .init(view: view, movieDetailResult: MovieDetailResult())
    }

    override func tearDown() {
        super.tearDown()
        view =  nil
        viewModel = nil
    }
    
    func test_viewDidLoad_InvokesRequiredMethods() {
        XCTAssertFalse(view.invokeConfigureNavigationBar)
        XCTAssertFalse(view.invokedSetUpUI)
        XCTAssertFalse(view.invokedSetUI)
    
        viewModel.viewDidLoad()
        
        XCTAssertEqual(view.invokedConfigureNavigationBarCount, 1)
        XCTAssertEqual(view.invokedSetUpUICount, 1)
        XCTAssertEqual(view.invokedSetUICount, 1)
    }
}
