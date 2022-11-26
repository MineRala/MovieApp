//
//  SplashViewModelTest.swift
//  MovieAppTests
//
//  Created by Mine Rala on 23.10.2022.
//

import XCTest
@testable import MovieApp

final class SplashViewModelTests: XCTestCase {
    //sut
    private var viewModel: SplashViewModel!
    private var view: MockSplashViewController!
   
    override func setUp() {
        super.setUp()
        view = .init()
        viewModel = .init(view: view)
    }

    override func tearDown() {
        super.tearDown()
        view =  nil
        viewModel = nil
    }
    
    func test_viewDidLoad_InvokesRequiredMethods_ConnectedInternet() {

        viewModel.viewDidLoad()
        
        XCTAssertEqual(view.invokedSetViewColorCount, 1)
      //  XCTAssertEqual(view.invokedDisplayLabelValueCount, 1)
        XCTAssertEqual(view.invokedSetUpLabelCount, 1)
        XCTAssertEqual(view.invokedPresentCount, 1)
    }
    
    func test_viewDidLoad_InvokedRequiredMethods_DisConnectedInternet() {

        viewModel.viewDidLoad()
       
       // XCTAssertTrue(invo)
        
       
    }
}
