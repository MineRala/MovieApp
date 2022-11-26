//
//  MockSplashViewModel.swift
//  MovieAppTests
//
//  Created by Mine Rala on 25.11.2022.
//

@testable import MovieApp
import UIKit
import FirebaseRemoteConfig

final class MockSplashViewModel: SplashViewModelInterface {
    var remoteConfig: RemoteConfig?
    
    var invokedViewDidLoad = false
  
    func viewDidLoad() {
        invokedViewDidLoad = true
    }

}
