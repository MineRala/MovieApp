//
//  MockDetailViewController.swift
//  MovieAppTests
//
//  Created by Mine Rala on 24.10.2022.
//

@testable import MovieApp
import UIKit

final class MockDetailViewController: DetailViewInterface {
    
    var invokeConfigureNavigationBar = false
    var invokedConfigureNavigationBarCount = 0
    
    func configureNavigationBar() {
        invokeConfigureNavigationBar = true
        invokedConfigureNavigationBarCount += 1
    }
    
    var invokedSetUpUI = false
    var invokedSetUpUICount = 0
    
    func setUpUI() {
        invokedSetUpUI = true
        invokedSetUpUICount += 1
    }
    
    var invokedSetUI = false
    var invokedSetUICount = 0
    
    func setUI(model: MovieDetailResult) {
        invokedSetUI = true
        invokedSetUICount += 1
    }
    
}
