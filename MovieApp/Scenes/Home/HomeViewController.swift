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
    static let emptyLabelText = "No Found Movie"
    static let searchText = "Search Movie"
    static let fontSize = 20
}

class HomeViewController: UIViewController, UISearchControllerDelegate {
    
    private lazy var searchVC: UISearchController = {
        let searchVC = UISearchController(searchResultsController: nil)
        searchVC.searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchVC
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
    
    var searchList = [Search]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        searchBar.searchBar.text = nil
//        searchBar.isActive = false
//    }

    private func configureNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        searchVC.searchBar.placeholder = HomeViewConstant.searchText
        navigationItem.title = HomeViewConstant.navigationBarTitle
        let attributes = [NSAttributedString.Key.foregroundColor:  HomeViewConstant.titleTextAttributesColor, NSAttributedString.Key.font : UIFont(name: FuturaFont.bold.rawValue, size: CGFloat(HomeViewConstant.fontSize))!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func setUpUI() {
        self.view.backgroundColor = HomeViewConstant.backgroundColor
        configureNavigationBar()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: HomeViewConstant.cellReuseIdentifier)
        
        self.view.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewConstant.cellReuseIdentifier,for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.setCell(model: searchList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedMovie(imdbID: searchList[indexPath.row].imdbID)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.loadIndicatorForApiRequestCompleted()
        searchVC.searchBar.isUserInteractionEnabled = false
        guard let text = searchBar.text, !text.isEmpty else { return }
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + .milliseconds(1500), execute: { [weak self] in
            NetworkManager.shared.moviesBySearchFetched(movieSearchTitle: text, completion: { [weak self] data in
                self?.dissmissIndicatorForApiRequestCompleted()
                self!.searchVC.searchBar.isUserInteractionEnabled = true
                if let data = data, text.count != 0  {
                    self?.emptyLabel.isHidden = true
                    self?.searchList = data
                } else {
                    self?.emptyLabel.isHidden = false
                    self?.searchList.removeAll()
                }
                DispatchQueue.main.async {
                    self?.reloadTableViewAfterIndicator()
                }
            })
        })
    }
        
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       reloadTableViewAfterIndicator()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        emptyLabel.isHidden = true
        searchList.removeAll()
        tableView.reloadData()
    }
}

extension HomeViewController {
    func loadIndicatorForApiRequestCompleted() {
        DispatchQueue.main.async {
            self.showLoadingView()
        }
    }

    func dissmissIndicatorForApiRequestCompleted() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + .milliseconds(30), execute: { [weak self] in
            self!.dismissLoadingView()
        })
    }

    func reloadTableViewAfterIndicator() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func selectedMovie(imdbID: String) {
        NetworkManager.shared.movieDetailsFetched(movieIMBID: imdbID) { result in
            guard let result = result else { return }
            self.openView(viewController: DetailViewController(movieDetailResult: result))
        }
    }
}
