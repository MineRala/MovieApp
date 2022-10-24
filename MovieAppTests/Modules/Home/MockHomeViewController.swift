//
//  MockHomeViewController.swift
//  MovieAppTests
//
//  Created by Mine Rala on 23.10.2022.
//

@testable import MovieApp
import UIKit

final class MockHomeViewController: HomeViewInterface {
    var invokedSetUpNavigationBar = false // novigationbar fonksiyonuna çağırılıp/çağırılmadığını
    var invokedSetUpNavigationBarCount = 0 // kaç kez navigationbar fonksiyonunu çağırdığını anlamak için
    
    func setUpNavigationBar() {
        invokedSetUpNavigationBar = true
        invokedSetUpNavigationBarCount += 1
    }
    
    var invokedSetUpUI = false
    var invokedSetUpUICount = 0
    
    func setUpUI() {
        invokedSetUpUI = true
        invokedSetUpUICount += 1
    }
    
    var invokedOpenView = false
    var invokedOpenViewCount = 0
    // Son çağırılan değer
    var invokedOpenViewParameters: (result: MovieDetailResult, Void)?
    // Tuple kullanmamızın nedeni parametre çok olduğunda bir standarda uydurmak için.
    // Bütün çağırılanları mapleyip cevabı döndürebilmek için
    var invokedOpenViewParametersList = [(result: MovieDetailResult, Void)]()
    // Örneğin 2 defa call etsek son invoke edilen değeri atayacak hepsini tutmak istiyorum o yüzden liste yarattım.
    func openView(result: MovieDetailResult) {
        invokedOpenView = true
        invokedOpenViewCount += 1
        invokedOpenViewParameters = (result: result, ())
        invokedOpenViewParametersList.append((result: result, ()))
    }
    
    var invokedReloadTableViewAfterIndicator = false
    var invokedReloadTableViewAfterIndicatorCount = 0
    
    func reloadTableViewAfterIndicator() {
        invokedReloadTableViewAfterIndicator = true
        invokedReloadTableViewAfterIndicatorCount += 1
    }
    
    var invokedDissmissIndicatorForApiRequestCompleted = false
    var invokedDissmissIndicatorForApiRequestCompletedCount = 0
    
    func dissmissIndicatorForApiRequestCompleted() {
        invokedDissmissIndicatorForApiRequestCompleted = true
        invokedDissmissIndicatorForApiRequestCompletedCount += 1
    }
    
    var invokedLoadIndicatorForApiRequestCompleted = false
    var invokedLoadIndicatorForApiRequestCompletedCount = 0
    
    func loadIndicatorForApiRequestCompleted() {
        invokedLoadIndicatorForApiRequestCompleted = true
        invokedLoadIndicatorForApiRequestCompletedCount += 1
    }
    
    var invokedSearchBarEnabled = false
    var invokedSearchBarEnabledCount = 0
    var invokedSearchBarEnabledParameters: (isEnable: Bool, Void)?
    var invokedSearchBarEnabledParametersList = [(isEnable: Bool, Void)]()
   
    func searchBarEnabled(isEnable: Bool) {
        invokedSearchBarEnabled = true
        invokedSearchBarEnabledCount += 1
    }
    
    var invokedEmptyLableIsHidden = false
    var invokedEmptyLableIsHiddenCount = 0
    var invokedEmptyLableIsHiddenParameters: (isHidden: Bool, Void)?
    var invokedEmptyLableIsHiddenParametersList = [(isHidden: Bool, Void)]()
    
    func emptyLabelIsHidden(isHidden: Bool) {
        invokedEmptyLableIsHidden = true
        invokedEmptyLableIsHiddenCount += 1
    }
}
