//
//  SplashViewModelTest.swift
//  MovieAppTests
//
//  Created by Mine Rala on 23.10.2022.
//

import XCTest
@testable import MovieApp

final class SplashViewModelTests: XCTestCase {
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
        XCTAssertFalse(view.invokedSetViewColor)
        XCTAssertFalse(view.invokedDisplayLabelValue)
        XCTAssertFalse(view.invokedSetUpLabel)
        XCTAssertFalse(view.invokedPresent)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(view.invokedSetViewColorCount, 1)
      //  XCTAssertEqual(view.invokedDisplayLabelValueCount, 1)
        XCTAssertEqual(view.invokedSetUpLabelCount, 1)
        XCTAssertEqual(view.invokedPresentCount, 1)
    }
    
    func test_viewDidLoad_InvokedRequiredMethods_DisConnectedInternet() {
        view.isConnect = false
       
        XCTAssertFalse(view.invokedSetViewColor)
        XCTAssertFalse(view.invokedShowToast)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(view.invokedSetViewColorCount, 1)
        XCTAssertFalse(view.isConnect)
    }
    
}
