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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
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
        label.text = "The ABC Murders The ABC Murders The ABC Murders The ABC Murders"
        return label
    }()
    
    private lazy var actorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FuturaFont.condesedMedium.of(size: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Lance Kerwin, Samaria Graham, Mara Hobel"
        return label
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FuturaFont.medium.of(size: 12)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var plotLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FuturaFont.medium.of(size: 12)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .purple
        return stackView
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
       
        setUpUI()
    }
    
    private func setUpUI() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)

        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        NSLayoutConstraint.activate([
          contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
          contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
          contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
          contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
          contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
          heightConstraint,
        ])
        
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.backgroundColor = .brown
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(20)
            make.right.left.equalTo(posterImageView)
            make.height.equalToSuperview().multipliedBy(0.04)
        }
        
        contentView.addSubview(actorLabel)
        actorLabel.backgroundColor = .blue
        actorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.right.left.equalTo(titleLabel)
            make.height.equalToSuperview().multipliedBy(0.04)
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(actorLabel.snp.bottom).offset(10)
            make.left.right.equalTo(titleLabel)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
    }
    
    @objc func close() {
        closeView()
    }
}

