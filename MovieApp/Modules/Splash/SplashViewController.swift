//
//  SplashViewController.swift
//  MovieApp
//
//  Created by Mine Rala on 17.10.2022.
//

import UIKit
import SnapKit

protocol SplashViewInterface: AnyObject {
    func setViewColor()
    func setUpLabel()
    func showToast()
    func present()
    func displayLabelValue()
}

final class SplashViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = Color.appBase
        label.font = FuturaFont.condensedExtraBold.of(size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    lazy var viewModel: SplashViewModelInterface = SplashViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - SplashViewController
extension SplashViewController: SplashViewInterface {
    func setViewColor() {
        self.view.backgroundColor = Color.white
    }
    
    func setUpLabel() {
        self.label.isHidden = false
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalToSuperview().multipliedBy(0.3)
        }
    }
    
    func showToast() {
        self.showToast(title: "Error", text: "There's no internet connection.", delay: 2)
    }
    
    func present() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.navigationController?.pushViewController(HomeViewController(), animated: false)
        }
    }
    
    func displayLabelValue() {
        DispatchQueue.main.async { [self] in
            label.text = viewModel.remoteConfig?.configValue(forKey: .labelText).stringValue ?? ""
        }
    }
}
