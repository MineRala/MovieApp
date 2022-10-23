//
//  HomeViewModelTests.swift
//  MovieAppTests
//
//  Created by Mine Rala on 23.10.2022.
//

import XCTest
@testable import MovieApp

final class HomeViewModelTests: XCTestCase {
    private var viewModel: HomeViewModel!
    private var view: MockHomeViewController!
    private var storeManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        view = .init()
        storeManager = .init()
        viewModel = .init(view: view, storeManager: storeManager)
    }

    override func tearDown() {
        super.tearDown()
        view =  nil
        storeManager = nil
        viewModel = nil
    }
    
    func test_heightForRowAt() {
        XCTAssertEqual(viewModel.heightForRowAt, 150)
    }
 
    func test_viewDidLoad_InvokesRequiredMethods() {
        XCTAssertFalse(view.invokedSetUpNavigationBar)
        XCTAssertFalse(view.invokedSetUpUI)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(view.invokedSetUpNavigationBarCount, 1)
        XCTAssertEqual(view.invokedSetUpUICount, 1)
    }
    
    func test_InvokesSetMovies() {
        XCTAssertFalse(view.invokedLoadIndicatorForApiRequestCompleted)
        XCTAssertFalse(((view.invokedSearchBarEnabledParameters?.0) != nil))
    }

    
}
