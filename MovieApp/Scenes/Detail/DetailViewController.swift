//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Mine Rala on 20.10.2022.
//

import UIKit

private enum DetailViewConstant {
    static let navigationBarTitle = "Movie Detail"
    static let titleTextAttributesColor = Color.appBase
    static let backgroundColor = Color.white
    static let backButtonIcon = "arrow.backward"
    
}

final class DetailViewController: UIViewController {
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FuturaFont.bold.of(size: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
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
        view.backgroundColor = DetailViewConstant.backgroundColor
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(close))
        backButton.setBackgroundImage(UIImage(systemName: DetailViewConstant.backButtonIcon), for: .normal, barMetrics: .default)
        backButton.tintColor = DetailViewConstant.titleTextAttributesColor
        navigationItem.setLeftBarButton(backButton, animated: false)
        navigationItem.title = DetailViewConstant.navigationBarTitle
        let attributes = [NSAttributedString.Key.foregroundColor: DetailViewConstant.titleTextAttributesColor , NSAttributedString.Key.font : UIFont(name: FuturaFont.bold.rawValue, size: 20)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    @objc func close() {
      closeView()
    }
}

