//
//  SplashViewControllerTest.swift
//  MovieAppTests
//
//  Created by Mine Rala on 25.11.2022.
//

import XCTest
@testable import MovieApp

final class SplashViewControllerTest: XCTestCase {
    private var spy: MockSplashViewModel!
    private var sut: SplashViewController!
   
    override func setUp() {
        super.setUp()
        spy = .init()
        sut = SplashViewController()
        sut.viewModel = spy
        sut.loadViewIfNeeded()

    }
    
    override func tearDown() {
        super.tearDown()
        sut =  nil
        spy = nil
    }

    func testViewDidLoad() {
        sut.viewDidLoad()
        XCTAssertTrue(spy.invokedViewDidLoad)
    }

}
