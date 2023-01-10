//
//  LoadingViewController.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import UIKit

class LoadingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        indicator.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        
        return indicator
    }()
    
    private var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.alpha = 0.7
        
        return blurView
    }()
    
    private func setupView() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
        blurView.frame = self.view.bounds
        loadingIndicator.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        view.addSubview(blurView)
        view.addSubview(loadingIndicator)
    }
}
