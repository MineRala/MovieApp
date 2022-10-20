//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Mine Rala on 17.10.2022.
//

import UIKit
import Alamofire

protocol NetworkManagerProtocol {
    func moviesBySearchFetched(movieSearchTitle: String, completion: @escaping ([Search]?) -> Void)
    func movieDetailsFetched(movieIMBID: String, completion: @escaping (MovieDetailResult?) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    func moviesBySearchFetched(movieSearchTitle: String, completion: @escaping ([Search]?) -> Void) {
        AF.request(Endpoint.movieSearchTitle(movieSearchTitle: movieSearchTitle).url).responseDecodable(of: MovieResult.self) { data in
            guard let data = data.value else {
                completion(nil)
                return
            }
            completion(data.search)
        }
    }
    
    func movieDetailsFetched(movieIMBID: String, completion: @escaping (MovieDetailResult?) -> Void) {
        AF.request(Endpoint.detailMovie(movieIMBID: movieIMBID).url).responseDecodable(of: MovieDetailResult.self) { data in
            guard let data = data.value else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
}
