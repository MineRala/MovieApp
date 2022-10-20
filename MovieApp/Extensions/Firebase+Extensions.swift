//
//  Firebase+Extensions.swift
//  MovieApp
//
//  Created by Mine Rala on 17.10.2022.
//

import FirebaseRemoteConfig

// MARK: - Remote Config
extension RemoteConfig {
    func configValue(forKey remoteConfigKey: RemoteConfigKey) -> RemoteConfigValue {
        return configValue(forKey: remoteConfigKey.rawValue)
    }
}

