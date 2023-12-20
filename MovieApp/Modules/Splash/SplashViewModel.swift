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
        /// Firebase Remote Config özelliğini kullanırken varsayılan değerleri ayarlamak için kullanılır.Yani, uzak yapılandırma değerleri alınamadığında veya belirli bir parametre için bir varsayılan değer tanımlanmamışsa, ilgili değer nil veya varsayılan Swift değerinde olacaktır.
        /// setDefaults fonksiyonu, belirtilen sözlüğü kullanarak, uzak yapılandırmadan değer alınamadığında veya alınan değer tipi beklenen tipe uymadığında kullanılacak varsayılan değerleri belirler. Bu, uygulamanın çalışma zamanındaki belirsiz durumları ele almanıza olanak tanır.
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        /// settings.minimumFetchInterval değerini 0 olarak ayarlamak, her çağrıda uzak yapılandırmayı indirir.
        self.remoteConfig?.configSettings = settings
        self.remoteConfig?.fetch(withExpirationDuration: 0) { [weak self] status, error in
            guard let self else { return }
            if status == .success, error == nil {
                self.remoteConfig?.activate { _, error in
                    guard error == nil else {
                        print("Remote Config Error = \(error.debugDescription)")
                        return
                    }
                    self.view?.displayLabelValue()
                }
            } else {
                print("Something went wrong")
            }
        }
    }
    
    private func checkConnectivity() {
        if Connectivity.isConnectedToInternet {
            fetchValue()
            view?.setUpLabel()
            view?.present()
        } else {
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
