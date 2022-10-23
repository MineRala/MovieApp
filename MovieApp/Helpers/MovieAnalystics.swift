//
//  MovieAnalystics.swift
//  MovieApp
//
//  Created by Mine Rala on 22.10.2022.
//

import FirebaseAnalytics

final class MovieAnalytics {
//MARK: - Send Log Event
    static func sendMovieDetailEvent(movie: MovieDetailResult) {
        Analytics.logEvent("Movie", parameters: ["movieName": movie.title, "movieGenre": movie.genre, "movieCountry": movie.country, "movieLanguage": movie.language, "movieActors": movie.actors, "moviePlot": movie.plot, "movieImage": movie.poster])
    }
}
