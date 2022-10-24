//
//  MockSplashViewController.swift
//  MovieAppTests
//
//  Created by Mine Rala on 23.10.2022.
//

@testable import MovieApp
import UIKit

final class MockSplashViewController: SplashViewInterface {
    var isConnect = Connectivity.isConnectedToInternet
    
    var invokedSetViewColor = false
    var invokedSetViewColorCount = 0
    
    func setViewColor() {
        invokedSetViewColor = true
        invokedSetViewColorCount += 1
    }
    
    var invokedSetUpLabel = false
    var invokedSetUpLabelCount = 0
    
    func setUpLabel() {
        invokedSetUpLabel = true
        invokedSetUpLabelCount += 1
    }
    
    var invokedShowToast = false
    var invokedShowToastCount = 0
    
    func showToast() {
        invokedShowToast = true
        invokedShowToastCount += 1
    }
    
    var invokedPresent = false
    var invokedPresentCount = 0
    
    func present() {
        invokedPresent = true
        invokedPresentCount += 1
    }
    
    var invokedDisplayLabelValue = false
    var invokedDisplayLabelValueCount = 0
    
    func displayLabelValue() {
        invokedDisplayLabelValue = true
        invokedDisplayLabelValueCount += 1
    }
}
