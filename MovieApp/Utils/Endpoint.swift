//
//  Endpoint.swift
//  MovieApp
//
//  Created by Mine Rala on 17.10.2022.
//

import Foundation

//http://www.omdbapi.com/?s=movieSearchTitle&apikey=48a7fc03
//http://www.omdbapi.com/?i=movieIMBID=&apikey=48a7fc03

enum Endpoint {
    enum Constant {
        static let baseURL = "http://www.omdbapi.com"
        static let apiKey = "48a7fc03"
    }

    case movieSearchTitle(movieSearchTitle: String)
    case detailMovie(movieIMBID: String)
    
    var url: String {
        switch self {
        case .movieSearchTitle(let movieSearchTitle):
            return "\(Constant.baseURL)?s=\(movieSearchTitle)&apiKey=\(Constant.apiKey)"
        case .detailMovie(let movieIMBID):
            return "\(Constant.baseURL)?i=\(movieIMBID)&apikey=\(Constant.apiKey)"
        }
    }
}
