//
//  Enums.swift
//  MovieApp
//
//  Created by Mine Rala on 17.10.2022.
//

import UIKit

// MARK: - Remote Config Enum
enum RemoteConfigKey: String {
    case labelText = "labelText"
}

// MARK: - Montserrat Font Enum
enum FuturaFont: String {
    case italic = "Futura-Medium-Italic"
    case medium = "Futura-Medium"
    case bold = "Futura-Bold"
    case condensedExtraBold = "Futura-CondensedExtraBold"
    case condesedMedium = "Futura-CondensedMedium"
   
    
    func of(size: CGFloat) -> UIFont? {
        return UIFont(name: rawValue, size: size)
    }
}
