//
//  SplashViewModel.swift
//  MovieApp
//
//  Created by Mine Rala on 17.10.2022.
//

import Foundation
import FirebaseRemoteConfig

protocol SplashViewModelInterface {
    var remoteConfig: RemoteConfig? { get }
    
    func viewDidLoad()
}

final class SplashViewModel {
    private weak var view: SplashViewInterface?
    
    init(view: SplashViewInterface) {
        self.view = view
    }
    
    private func fetchValue()  {
        let defaults: [String: NSObject] = [
            "labelText": "Movie App" as NSObject
        ]
        remoteConfig?.setDefaults(defaults)
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        self.remoteConfig?.fetch(withExpirationDuration: 0) { [self] status, error in
            if status == .success, error == nil {
                remoteConfig?.activate { _, error in
                    guard error == nil else {
                        print("Remote Config Error = \(error.debugDescription)")
                        return
                    }
                    self.view?.displayLabelValue()
                    }
                }
             else {
                print("Something went wrong")
            }
        }
    }
    
    private func checkConnectivity() {
        if Connectivity.isConnectedToInternet {
            fetchValue()
            view?.setUpLabel()
            view?.present()
        }
        else {
            view?.showToast()
        }
    }
}

//MARK: - SplashViewModelInterface
extension SplashViewModel: SplashViewModelInterface {
    var remoteConfig: RemoteConfig? {
        get {
            RemoteConfig.remoteConfig()
        }
    }
    
    func viewDidLoad() {
        view?.setViewColor()
        checkConnectivity()
    }
}
