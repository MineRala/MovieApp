//
//  UIViewController+Extension.swift
//  MovieApp
//
//  Created by Mine Rala on 17.10.2022.
//


import UIKit
import SnapKit

fileprivate var containerView: UIView!

extension UIViewController {
    func showToast(title:String ,text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
        alert.dismiss(animated: true, completion: nil)
        })
    }
    
    func showLoadingView() {
        containerView = UIView()
        self.view.addSubview(containerView)
        containerView.backgroundColor = #colorLiteral(red: 0.1097382233, green: 0.6288500428, blue: 0.6367314458, alpha: 1).withAlphaComponent(0.7)
        containerView.alpha = 0
        containerView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.width.equalTo(150)
        }
        UIView.animate(withDuration: 0.5) {
            containerView.alpha = 1
            containerView.layer.masksToBounds = true
            containerView.clipsToBounds = true
            containerView.layer.cornerRadius = 100
        }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.snp.makeConstraints { (make) in
        make.centerX.equalToSuperview()
        make.centerY.equalToSuperview()
        activityIndicator.startAnimating()

        }
    }

    func dismissLoadingView() {
        containerView?.removeFromSuperview()
        containerView = nil
    }
}
