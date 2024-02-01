//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Mine Rala on 23.10.2022.
//

import Foundation
import FirebaseAnalytics

protocol DetailViewModelInterface {
    func viewDidLoad(imdbId: String)
}

// MARK: - Class Bone
final class DetailViewModel {
    private weak var view: DetailViewInterface?
    private let storeManager: NetworkManagerProtocol
   
    init(view: DetailViewInterface, storeManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.view = view
        self.storeManager = storeManager
    }
    
    private func setMovieDetails(imdbId: String) {
        view?.loadIndicatorForApiRequestCompleted()
        storeManager.makeRequest(endpoint: .detailMovie(movieIMBID: imdbId), type: MovieDetailResult.self) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                self.view?.dissmissIndicatorForApiRequestCompleted()
            }
            switch result {
            case .success(let movieDetailResult):
                print("Current Thread: \(Thread.current)")
                MovieAnalyticsManager.shared.sendMovieDetailEvent(movie: movieDetailResult)
                DispatchQueue.main.async {
                    self.view?.setUI(model: movieDetailResult)
                }
            case .failure(_):
                let actions: AlertAction = [
                    ("Okey".uppercased(),
                     .default, {
                         print("Okey button tapped.")
                         self.view?.backToHomeScreen()
                     }),
                ]
                DispatchQueue.main.sync {
                    self.view?.showErrorAlert(title: "Error", description: "Data could not be retrieved.", actions: actions)
                }
            }
        }
    }
}

//MARK: - DetailViewModelInterface
extension DetailViewModel: DetailViewModelInterface {
    func viewDidLoad(imdbId: String) {
        self.view?.configureNavigationBar()
        self.view?.setUpUI()
        self.setMovieDetails(imdbId: imdbId)
    }
}
