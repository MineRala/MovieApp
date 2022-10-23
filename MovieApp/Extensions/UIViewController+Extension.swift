//
//  UIViewController+Extension.swift
//  MovieApp
//
//  Created by Mine Rala on 17.10.2022.
//


import UIKit
import SnapKit

fileprivate var containerView: UIView!

//MARK: - Toast
extension UIViewController {
    func showToast(title:String ,text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
        })
    }
}

//MARK: - Loding View
extension UIViewController {
    func showLoadingView() {
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerView)
        containerView.backgroundColor = Color.appBase.withAlphaComponent(0.7)
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
            make.centerX.centerY.equalToSuperview()
        }
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        containerView?.removeFromSuperview()
        containerView = nil
    }
}

//MARK: - View Animation
extension UIViewController {
    func openView(viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    func closeView() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromBottom
        navigationController?.view.layer.add(transition, forKey:kCATransition)
        navigationController?.popViewController(animated: false)
    }
}
