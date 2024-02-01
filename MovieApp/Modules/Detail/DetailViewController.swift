//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Mine Rala on 20.10.2022.
//

import UIKit
import SnapKit

private enum DetailViewConstant {
    static let cellReuseIdentifier = "GenreCollectionViewCell"
    static let navigationBarTitle = "Movie Detail"
    static let titleTextAttributesColor = Color.appBase
    static let backgroundColor = Color.white
    static let cellBackgroundColor = Color.viewBackgrounColor
    static let cellBorderColor = Color.black
    static let backButtonIcon = "arrow.backward"
    static let cellSpacing = 20.0
    static let cellSize = CGSize(width: 100, height: 32)
    static let cornerRadius = 8.0
    static let borderWidth = 1.0
    static let fontSize = 20.0
}

protocol DetailViewInterface: AnyObject {
    func configureNavigationBar()
    func setUpUI()
    func setUI(model: MovieDetailResult)
    func showErrorAlert(title: String, description: String, actions: AlertAction)
    func backToHomeScreen()
    func loadIndicatorForApiRequestCompleted()
    func dissmissIndicatorForApiRequestCompleted()
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
        label.textColor = Color.black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var actorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FuturaFont.condesedMedium.of(size: 16)
        label.textColor = Color.black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FuturaFont.medium.of(size: 14)
        label.textColor = Color.black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FuturaFont.medium.of(size: 14)
        label.textColor = Color.black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var plotTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = FuturaFont.medium.of(size: 16)
        textView.textColor = Color.black
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.textAlignment = .left
        return textView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        flowLayout.scrollDirection = .horizontal
        collectionView.backgroundColor = Color.white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: DetailViewConstant.cellReuseIdentifier)
        return collectionView
    }()
    
    private var genreArray = [String]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private var viewModel: DetailViewModelInterface?
    public var imdbID: String?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewModel = DetailViewModel(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel else { return }
        viewModel.viewDidLoad(imdbId: imdbID ?? "")
    }
}

//MARK: - Actions
extension DetailViewController {
    @objc func close() {
        closeView()
    }
    
    private func genreSplit(text: String) -> [String] {
        return text.components(separatedBy: ", ")
    }
}

//MARK: - CollectionView DataSource
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genreArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailViewConstant.cellReuseIdentifier,for: indexPath) as? GenreCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = DetailViewConstant.cellBackgroundColor
        cell.layer.cornerRadius = DetailViewConstant.cornerRadius
        cell.layer.borderWidth = DetailViewConstant.borderWidth
        cell.layer.borderColor = DetailViewConstant.cellBackgroundColor.cgColor
        cell.setCell(title: genreArray[indexPath.row])
        return cell
    }
}

//MARK: - CollectionView Delegate Flow Layout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        DetailViewConstant.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        DetailViewConstant.cellSpacing
    }
}

//MARK: - DetailViewInterface
extension DetailViewController: DetailViewInterface {
    func configureNavigationBar() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(close))
        backButton.setBackgroundImage(UIImage(systemName: DetailViewConstant.backButtonIcon), for: .normal, barMetrics: .default)
        backButton.tintColor = DetailViewConstant.titleTextAttributesColor
        navigationItem.setLeftBarButton(backButton, animated: false)
        navigationItem.title = DetailViewConstant.navigationBarTitle
        let attributes = [NSAttributedString.Key.foregroundColor: DetailViewConstant.titleTextAttributesColor , NSAttributedString.Key.font : UIFont(name: FuturaFont.bold.rawValue, size: DetailViewConstant.fontSize)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    func setUpUI() {
        view.backgroundColor = DetailViewConstant.backgroundColor
        view.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(20)
            make.right.left.equalTo(posterImageView)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        
        view.addSubview(actorLabel)
        actorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.right.left.equalTo(titleLabel)
            make.height.equalToSuperview().multipliedBy(0.04)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(actorLabel.snp.bottom).offset(10)
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(32)
        }
        
        stackView.addArrangedSubview(countryLabel)
        stackView.addArrangedSubview(languageLabel)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.left.right.equalTo(stackView)
            make.height.equalTo(40)
        }
        
        view.addSubview(plotTextView)
        plotTextView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.left.right.equalTo(collectionView)
            make.bottom.equalTo(view.snp.bottom).offset(-20)
        }
    }
    
    func setUI(model: MovieDetailResult) {
        if model.poster == "N/A" {
            posterImageView.image = UIImage(named: "NoImage")
        } else {
            posterImageView.kf.setImage(with: URL(string: model.poster))
        }
        titleLabel.text = model.title
        actorLabel.text = model.actors
        countryLabel.text = "Country: \(model.country)"
        languageLabel.text = "Language: \(model.language)"
        genreArray = genreSplit(text: model.genre)
        plotTextView.text = model.plot
    }
    
    func showErrorAlert(title: String, description: String, actions: AlertAction) {
        showCustomAlert(title: title, message: description, actions: actions)
    }
    
    func backToHomeScreen() {
        closeView()
    }

    func dissmissIndicatorForApiRequestCompleted() {
        DispatchQueue.main.async {
            self.dismissLoadingView()
        }
    }
    
    func loadIndicatorForApiRequestCompleted() {
        DispatchQueue.main.async {
            self.showLoadingView()
        }
    }
}
