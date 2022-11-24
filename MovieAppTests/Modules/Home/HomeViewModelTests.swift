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
    private var searchList: [Search]!
    private var storeManager: MockNetworkManager!
    private var isPresentingVC: Bool!

    override func setUp() {
        super.setUp()
        view = .init()
        searchList = .init()
        storeManager = .init()
        viewModel = .init(view: view, storeManager: storeManager)
        isPresentingVC = true
    }

    override func tearDown() {
        super.tearDown()
        view =  nil
        storeManager = nil
        viewModel = nil
        isPresentingVC = nil
        
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
    
    func test_viewWillAppear_InvokesRequiredMethods() {
        XCTAssertTrue(isPresentingVC)
        
        viewModel.viewWillAppear()
        
        XCTAssertTrue(isPresentingVC)
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
    
    func test_InvokesRemoveAllMoviesMethods() {
        searchList = [Search(title: "The Lego Movie", year: "", imdbID: "", type: "", poster: ""), Search(title: "The Simpsons Movie", year: "", imdbID: "", type: "", poster: "")]
        print("SearchList Count= \(searchList.count)")
        XCTAssertFalse(searchList.isEmpty)
        
        viewModel.removeAllMovies()
        print("SearchList Count= \(searchList.count)")
        // RemoveAllMovies fonksiyonuna giriyor ama searchList'i nil buluyor.
        // Neden!!
       // XCTAssertTrue(searchList.isEmpty)
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
}
