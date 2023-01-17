//
//  DialogueService.swift
//  NetworkLayer
//
//  Created by Matthew Roberts on 24/08/2022.
//

import UIKit

protocol Dialogued {
    func showDialogue(on viewController: UIViewController, data: DialogueData, buttonActionClosure: (() -> Void)?)
}

struct DialogueService: Dialogued {
    func showDialogue(on viewController: UIViewController, data: DialogueData, buttonActionClosure: (() -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let viewModel = DialogueViewModel(data: data)
            let dialogueView = DialogueViewController()
            
            dialogueView.viewModel = viewModel
            dialogueView.buttonAction = buttonActionClosure
            
            dialogueView.modalPresentationStyle = .overCurrentContext
            dialogueView.modalTransitionStyle = .crossDissolve
            
            viewController.present(dialogueView, animated: true, completion: nil)
        }
    }
}
