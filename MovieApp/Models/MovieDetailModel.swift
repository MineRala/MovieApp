//
//  MovieDetailModel.swift
//  MovieApp
//
//  Created by Mine Rala on 17.10.2022.
//

import Foundation

// MARK: - MovieDetailResults
struct MovieDetailResult: Codable {
    let title, year, rated, released, runtime, genre, director, writer, actors, plot, country, language,awards, poster, imdbRating: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case country = "Country"
        case language = "Language"
        case awards = "Awards"
        case poster = "Poster"
        case imdbRating
    
    }
}
