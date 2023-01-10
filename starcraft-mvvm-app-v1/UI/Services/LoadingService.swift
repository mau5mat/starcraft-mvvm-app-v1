//
//  Loadable.swift
//  NetworkLayer
//
//  Created by Matthew Roberts on 23/08/2022.
//

import UIKit

protocol Loadable {
    func showLoading(on: UIViewController)
    func hideLoading(on: UIViewController, completion: (() -> Void)?)
}

struct LoadingService: Loadable {
    func showLoading(on viewController: UIViewController) {
        DispatchQueue.main.async {
            let loadingView = LoadingViewController()
            loadingView.modalPresentationStyle = .overCurrentContext
            loadingView.modalTransitionStyle = .crossDissolve
            
            viewController.present(loadingView, animated: true, completion: nil)
        }
    }
    
    func hideLoading(on viewController: UIViewController, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                if let loadingViewController = viewController.presentedViewController as? LoadingViewController {
                    loadingViewController.dismiss(animated: true, completion: completion)
                }
                timer.invalidate()
            }
        }
    }
}
