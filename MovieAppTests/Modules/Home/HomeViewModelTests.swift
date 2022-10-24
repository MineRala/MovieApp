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
    
    func test_InvokesSetMoviesSuccess() {
        XCTAssertFalse(view.invokedLoadIndicatorForApiRequestCompleted)
        XCTAssertFalse(view.invokedSearchBarEnabled)
        XCTAssertFalse(view.invokedDissmissIndicatorForApiRequestCompleted)
        XCTAssertFalse(view.invokedSearchBarEnabled)
        XCTAssertFalse(view.invokedEmptyLableIsHidden)
        XCTAssertFalse(view.invokedReloadTableViewAfterIndicator)
        
        viewModel.setMovies(text: "Abc")
        
        XCTAssertEqual(view.invokedLoadIndicatorForApiRequestCompletedCount, 1)
        XCTAssertEqual(view.invokedSearchBarEnabledCount, 1)

    }
    
    func test_InvokesSetMoviesFail() {
        XCTAssertFalse(view.invokedLoadIndicatorForApiRequestCompleted)
        XCTAssertFalse(view.invokedSearchBarEnabled)
        XCTAssertFalse(view.invokedDissmissIndicatorForApiRequestCompleted)
        XCTAssertFalse(view.invokedSearchBarEnabled)
        XCTAssertFalse(view.invokedEmptyLableIsHidden)
        XCTAssertFalse(view.invokedReloadTableViewAfterIndicator)
        
        viewModel.setMovies(text: "A")
        
        XCTAssertEqual(view.invokedLoadIndicatorForApiRequestCompletedCount, 1)
        XCTAssertEqual(view.invokedSearchBarEnabledCount, 1)
//        XCTAssertEqual(view.invokedDissmissIndicatorForApiRequestCompletedCount, 1)
//        XCTAssertEqual(view.invokedSearchBarEnabledCount, 2)
//        XCTAssertEqual(view.invokedEmptyLableIsHiddenCount, 2)
//        XCTAssertEqual(view.invokedReloadTableViewAfterIndicatorCount, 1)

    }
    
    func test_InvokesSelectedMovieSuccess() {
        XCTAssertFalse(view.invokedOpenView)
        
        viewModel.selectedMovie(imdbID: "tt0386438")
        
        //XCTAssertEqual(view.invokedOpenViewCount, 1)
    }
    
    func test_InvokesSelectedMovieFail() {
        XCTAssertFalse(view.invokedOpenView)
        
        viewModel.selectedMovie(imdbID: "0000000")
        
        XCTAssertEqual(view.invokedOpenViewCount, 0)
    }
}
