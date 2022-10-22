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
    var searchList = [Search]()
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
            NetworkManager.shared.moviesBySearchFetched(movieSearchTitle: text, completion: { [weak self] data in
                self?.view?.dissmissIndicatorForApiRequestCompleted()
                self?.view?.searchBarEnabled(isEnable: true)
                if let data = data, text.count != 0  {
                    self?.view?.emptyLableIsHidden(isHidden: true)
                    self?.searchList = data
                } else {
                    self?.view?.emptyLableIsHidden(isHidden: false)
                    self?.searchList.removeAll()
                }
                DispatchQueue.main.async {
                    self?.view?.reloadTableViewAfterIndicator()
                }
            })
        })
    }
    
    func getMovie(index: Int) -> Search {
        searchList[index]
    }
    
    func selectedMovie(imdbID: String) {
        NetworkManager.shared.movieDetailsFetched(movieIMBID: imdbID) { [weak self] result in
            guard let result = result else { return }
            self?.view?.openView(result: result)
        }
    }
        
    func removeAllMovies() {
        searchList.removeAll()
    }
}
