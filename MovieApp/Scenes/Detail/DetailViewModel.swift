//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Mine Rala on 23.10.2022.
//

import Foundation
import FirebaseAnalytics

protocol DetailViewModelInterface {
    var view: DetailViewInterface? { get set }
    var getMovieResult: MovieDetailResult { get }
    
    func viewDidLoad()
    func genreSplit(text: String) -> [String]
}

final class DetailViewModel {
    weak var view: DetailViewInterface?
    private var movieDetailResult: MovieDetailResult
  
    init(movieDetailResult: MovieDetailResult) {
        self.movieDetailResult = movieDetailResult
    }
}

extension DetailViewModel: DetailViewModelInterface {
    var getMovieResult: MovieDetailResult {
        movieDetailResult
    }
    
    func viewDidLoad() {
        MovieAnalytics.shared.sendMovieDetailEvent(movie: movieDetailResult)
        view?.configureNavigationBar()
        view?.setUpUI()
        view?.setUI(model: movieDetailResult)
    }
    
    func genreSplit(text: String) -> [String] {
        return text.components(separatedBy: ", ")
    }
    
}
