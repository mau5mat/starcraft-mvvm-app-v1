//
//  DialogueViewController.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import UIKit

class DialogueViewController: UIViewController {
    var viewModel: DialogueViewModel!
    
    var buttonAction: (() -> Void)?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupAlertView()
    }
    
    private func setupAlertView() {
        let alertView = createAlert()
        
        blurView.frame = self.view.bounds
        
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.addSubview(blurView)
        
        present(alertView, animated: true)
    }

    private func createAlert() -> UIAlertController {
        switch viewModel.type {
        case .alert:
            return createAlertDialogue()
        case .error:
            return createErrorDialogue()
        case .cancel:
            return createCancelAlertDialogue()
        }
    }
    
    private func createCancelAlertDialogue() -> UIAlertController {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.buttonAction!()
            self?.dismiss(animated: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        return alert
    }
    
    private func createAlertDialogue() -> UIAlertController {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        alert.addAction(action)
        
        return alert
    }
    
    private func createErrorDialogue() -> UIAlertController {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        alert.addAction(action)
        
        return alert
    }
    
    private var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.alpha = 0.7
        
        return blurView
    }()
}
