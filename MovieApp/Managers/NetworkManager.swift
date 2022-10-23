//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Mine Rala on 17.10.2022.
//

import UIKit
import Alamofire

protocol NetworkManagerProtocol {
    func makeRequest<T: Decodable>(endpoint: Endpoint, type: T.Type, completed: @escaping (Result<T, MovieError>) -> Void)
}

protocol NetworkManagerDelegate: AnyObject {
    func moviesBySearchFetched(movieSearchTitle: String)
    func movieDetailsFetched(movieIMBID: String)
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    func makeRequest<T: Decodable>(endpoint: Endpoint, type: T.Type, completed: @escaping (Result<T, MovieError>) -> Void) {
        AF.request(endpoint.url).responseDecodable(of: T.self) { result in
            guard let result = result.value else {
                completed(.failure(.invalidData))
                return
            }
            completed(.success(result))
        }
    }
}
