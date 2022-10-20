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
        label.textColor = #colorLiteral(red: 0.1097382233, green: 0.6288500428, blue: 0.6367314458, alpha: 1)
        label.font = FuturaFont.condensedExtraBold.of(size: 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private lazy var viewModel: SplashViewModelInterface = SplashViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension SplashViewController: SplashViewInterface {
    func setViewColor() {
        self.view.backgroundColor = .white
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
            let vc = HomeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func displayLabelValue() {
        DispatchQueue.main.async { [self] in
            label.text = viewModel.remoteConfig?.configValue(forKey: .labelText).stringValue ?? ""
        }
    }
}
