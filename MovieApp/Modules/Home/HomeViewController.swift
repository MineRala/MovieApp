//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Mine Rala on 17.10.2022.
//

import UIKit
import SnapKit

private enum HomeViewConstant {
    static let cellReuseIdentifier = "MovieTableViewCell"
    static let navigationBarTitle = "Movies"
    static let titleTextAttributesColor = Color.appBase
    static let backgroundColor = Color.white
    static let emptyLabelText = "No Movies Found!"
    static let searchText = "Search Movie"
    static let fontSize = 20.0
}

protocol HomeViewInterface: AnyObject {
    func setUpNavigationBar()
    func setUpUI()
    func openView(result: MovieDetailResult)
    func reloadTableViewAfterIndicator()
    func dissmissIndicatorForApiRequestCompleted()
    func loadIndicatorForApiRequestCompleted()
    func searchBarEnabled(isEnable: Bool)
    func emptyLabelIsHidden(isHidden: Bool)
}

final class HomeViewController: UIViewController, UISearchControllerDelegate {
    
    private lazy var searchVC: UISearchController = {
        let searchVC = UISearchController(searchResultsController: nil)
        searchVC.searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchVC
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: HomeViewConstant.cellReuseIdentifier)
        return tableView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.font = FuturaFont.bold.of(size: 16)
        label.textColor = HomeViewConstant.titleTextAttributesColor
        label.textAlignment = .left
        label.text = HomeViewConstant.emptyLabelText
        label.isHidden = true
        return label
    }()
    
    private lazy var viewModel: HomeViewModelInterface = HomeViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

//MARK: - TableView DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewConstant.cellReuseIdentifier,for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.setCell(model: viewModel.getMovie(index: indexPath.row))
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - TableView Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectedMovie(imdbID: viewModel.getMovie(index: indexPath.row).imdbID)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRowAt
    }
}

//MARK: - SearchBar Delegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        viewModel.setMovies(text: text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        emptyLabel.isHidden = true
        viewModel.removeAllMovies()
        tableView.reloadData()
    }
}

// MARK: - HomeViewInterface
extension HomeViewController: HomeViewInterface {
    func setUpNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        searchVC.searchBar.placeholder = HomeViewConstant.searchText
        navigationItem.title = HomeViewConstant.navigationBarTitle
        let attributes = [NSAttributedString.Key.foregroundColor:  HomeViewConstant.titleTextAttributesColor, NSAttributedString.Key.font : UIFont(name: FuturaFont.bold.rawValue, size: HomeViewConstant.fontSize)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    func setUpUI() {
        self.view.backgroundColor = HomeViewConstant.backgroundColor
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        self.view.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func openView(result: MovieDetailResult) {
        openView(viewController: DetailViewController(movieDetailResult: result))
    }
    
    func reloadTableViewAfterIndicator() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func dissmissIndicatorForApiRequestCompleted() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + .milliseconds(30), execute: {
            self.dismissLoadingView()
        })
    }
    
    func loadIndicatorForApiRequestCompleted() {
        DispatchQueue.main.async {
            self.showLoadingView()
        }
    }
    
    func searchBarEnabled(isEnable: Bool) {
        searchVC.searchBar.isUserInteractionEnabled = isEnable
    }

    func emptyLabelIsHidden(isHidden: Bool) {
        emptyLabel.isHidden = isHidden
    }
}
