//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Mine Rala on 22.10.2022.
//

import Foundation

protocol HomeViewModelInterface {
    var numberOfRowsInSection: Int { get }
    var heightForRowAt: Double { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func removeAllMovies()
    func setMovies(text: String)
    func getMovie(index: Int) -> Search
    func didSelectRowAt(index: Int)
}

// MARK: - Constants
private struct Constant {
    static let cellHeight: Double = 150.0
}

// MARK: - Class Bone
final class HomeViewModel {
    private weak var view: HomeViewInterface?
    internal var searchList = [Search]()
    private let storeManager: NetworkManagerProtocol
    internal var isPresentingVC = true
    
    init(view: HomeViewInterface, storeManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.view = view
        self.storeManager = storeManager
    }

    private func selectedMovie(imdbID: String) {
        self.view?.openView(imdbID: imdbID)
    }
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

    func viewWillAppear() {
        isPresentingVC = true
    }

    func setMovies(text: String) {
        view?.loadIndicatorForApiRequestCompleted()
        view?.searchBarEnabled(isEnable: false)
        guard !text.isEmpty else { return }
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + .milliseconds(1500), execute: { [weak self] in
            self?.storeManager.makeRequest(endpoint: .movieSearchTitle(movieSearchTitle: text), type: MovieResult.self, completed: { result in
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

    func removeAllMovies() {
        searchList.removeAll()
    }

    func didSelectRowAt(index: Int) {
        if isPresentingVC {
            isPresentingVC = false
            selectedMovie(imdbID: searchList[index].imdbID)
        }
    }
}
