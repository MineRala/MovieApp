//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Mine Rala on 22.10.2022.
//

import Foundation

protocol HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    var numberOfRowsInSection: Int { get }
    var heightForRowAt: Double { get }
    
    func viewDidLoad()
    func selectedMovie(imdbID: String)
    func removeAllMovies()
    func setMovies(text: String)
    func getMovie(index: Int) -> Search
}

private extension HomeViewModel {
    enum Constant {
        static let cellHeight: Double = 150.0
    }
}

final class HomeViewModel {
    weak var view: HomeViewInterface?
    private var searchList = [Search]()
    private var service = NetworkManager.shared
}

//MARK: - HomeViewModelInterface
extension HomeViewModel: HomeViewModelInterface {
    var numberOfRowsInSection: Int {
        searchList.count
    }
    
    var heightForRowAt: Double {
        Constant.cellHeight
    }
    
    func viewDidLoad() {
        view?.setUpNavigationBar()
        view?.setUpUI()
    }

    func setMovies(text: String) {
        self.view?.loadIndicatorForApiRequestCompleted()
        view?.searchBarEnabled(isEnable: false)
        guard !text.isEmpty else { return }
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + .milliseconds(1500), execute: { [weak self] in
            self?.service.makeRequest(endpoint: .movieSearchTitle(movieSearchTitle: text), type: MovieResult.self, completed: { result in
                self?.view?.dissmissIndicatorForApiRequestCompleted()
                self?.view?.searchBarEnabled(isEnable: true)
                switch result {
                case .success(let movieResults):
                    self?.view?.emptyLabelIsHidden(isHidden: true)
                    self?.searchList = movieResults.search
                case .failure(let error):
                    print(error)
                    self?.view?.emptyLabelIsHidden(isHidden: false)
                    self?.searchList.removeAll()
                }
                self?.view?.reloadTableViewAfterIndicator()
            })
        })
    }

    func getMovie(index: Int) -> Search {
        searchList[index]
    }
    
    func selectedMovie(imdbID: String) {
        service.makeRequest(endpoint: .detailMovie(movieIMBID: imdbID), type: MovieDetailResult.self) { [weak self] result in
            switch result {
            case .success(let movieDetailResult):
                self?.view?.openView(result: movieDetailResult)
            case .failure(let error):
                print(error)
            }
        }
    }
        
    func removeAllMovies() {
        searchList.removeAll()
    }
}
