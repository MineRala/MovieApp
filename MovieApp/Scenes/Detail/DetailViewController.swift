//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Mine Rala on 20.10.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    private var movieDetailResult: MovieDetailResult
    
    init(movieDetailResult: MovieDetailResult) {
        self.movieDetailResult = movieDetailResult
        print(movieDetailResult)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
