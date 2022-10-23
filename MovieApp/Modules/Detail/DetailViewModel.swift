//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Mine Rala on 23.10.2022.
//

import Foundation
import FirebaseAnalytics

protocol DetailViewModelInterface {
    var getMovieResult: MovieDetailResult { get }
    
    func viewDidLoad()
    func genreSplit(text: String) -> [String]
}

final class DetailViewModel {
    private weak var view: DetailViewInterface?
    private var movieDetailResult: MovieDetailResult
  
    init(view: DetailViewInterface, movieDetailResult: MovieDetailResult) {
        self.view = view
        self.movieDetailResult = movieDetailResult
    }
}

extension DetailViewModel: DetailViewModelInterface {
    var getMovieResult: MovieDetailResult {
        movieDetailResult
    }
    
    func viewDidLoad() {
        MovieAnalyticsManager.shared.sendMovieDetailEvent(movie: movieDetailResult)
        view?.configureNavigationBar()
        view?.setUpUI()
        view?.setUI(model: movieDetailResult)
    }
    
    func genreSplit(text: String) -> [String] {
        return text.components(separatedBy: ", ")
    }
    
}
