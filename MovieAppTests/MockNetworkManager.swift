//
//  MockNetworkManager.swift
//  MovieAppTests
//
//  Created by Mine Rala on 23.10.2022.
//

@testable import MovieApp

final class MockNetworkManager: NetworkManagerProtocol {
    var invokeMakeRequest = false
    var invokeMakeRequestCount = 0
    
    func makeRequest<T>(endpoint: Endpoint, type: T.Type, completed: @escaping (Result<T, MovieError>) -> Void) where T : Decodable {
        invokeMakeRequest = true
        invokeMakeRequestCount += 1
       // completed(Result<T, MovieError>)
    }
}
