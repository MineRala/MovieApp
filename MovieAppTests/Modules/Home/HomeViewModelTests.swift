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
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(view.invokedSetUpNavigationBarCount, 1)
        XCTAssertEqual(view.invokedSetUpUICount, 1)
    }
    
    func test_viewWillAppear_InvokesRequiredMethods() {
//        XCTAssertFalse(isPresentingVC)
        
        viewModel.viewWillAppear()
        
        XCTAssertTrue(viewModel.isPresentingVC)
    }
        
    func test_InvokesRemoveAllMoviesMethods() {
        viewModel.searchList = [Search(title: "The Lego Movie", year: "", imdbID: "", type: "", poster: ""), Search(title: "The Simpsons Movie", year: "", imdbID: "", type: "", poster: "")]
      
        XCTAssertFalse(viewModel.searchList.isEmpty)
        
        viewModel.removeAllMovies()
        
        XCTAssertTrue(viewModel.searchList.isEmpty)
    }
    
    func test_InvokesSetMoviesSuccess() {
        
        viewModel.setMovies(text: "Abc")
        
        XCTAssertEqual(view.invokedLoadIndicatorForApiRequestCompletedCount, 1)
        XCTAssertEqual(view.invokedSearchBarEnabledCount, 1)
    
    }
    
    func test_InvokesSetMoviesFail() {
        
        viewModel.setMovies(text: "A")
        
        XCTAssertEqual(view.invokedLoadIndicatorForApiRequestCompletedCount, 1)
        XCTAssertEqual(view.invokedSearchBarEnabledCount, 1)
//        XCTAssertEqual(view.invokedDissmissIndicatorForApiRequestCompletedCount, 1)
//        XCTAssertEqual(view.invokedSearchBarEnabledCount, 2)
//        XCTAssertEqual(view.invokedEmptyLableIsHiddenCount, 2)
//        XCTAssertEqual(view.invokedReloadTableViewAfterIndicatorCount, 1)

    }
    
    func test_InvokesDidSelectRowAt() {
        viewModel.searchList = [Search(title: "The Lego Movie", year: "", imdbID: "", type: "", poster: ""), Search(title: "The Simpsons Movie", year: "", imdbID: "", type: "", poster: "")]
        viewModel.didSelectRowAt(index: 0)
        XCTAssertFalse(viewModel.isPresentingVC)
    }
}
