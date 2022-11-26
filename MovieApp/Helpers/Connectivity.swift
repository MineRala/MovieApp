//
//  Connectivity.swift
//  MovieApp
//
//  Created by Mine Rala on 17.10.2022.
//

import Foundation
import Alamofire

final class Connectivity {
    static var isConnectedToInternet: Bool {
            return NetworkReachabilityManager()!.isReachable
        }
}
