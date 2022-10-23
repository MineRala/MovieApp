//
//  MovieDetailModel.swift
//  MovieApp
//
//  Created by Mine Rala on 17.10.2022.
//

import Foundation

//MARK: - MovieDetailResults
struct MovieDetailResult: Codable {
    let title, genre, actors, plot, country, language, poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case genre = "Genre"
        case actors = "Actors"
        case plot = "Plot"
        case country = "Country"
        case language = "Language"
        case poster = "Poster"
    }
}
