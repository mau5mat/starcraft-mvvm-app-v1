//
//  UnitPageCoordinator.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 10/01/2023.
//

import UIKit

class UnitPageCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var unit: SCUnit
    
    init(navigationController: UINavigationController, unit: SCUnit) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
        
        self.unit = unit
    }
    
    func start() {
        let viewModel = UnitPageViewModel(unit: unit)
        
        let viewController = UnitPageViewController.instantiate(storyboard: "UnitPage")
        viewController.loadingService = LoadingService()
        viewController.dialogueService = DialogueService()
        viewController.viewModel = viewModel
    
        let unitPageNavigationController = UINavigationController()
        unitPageNavigationController.viewControllers = [viewController]
        unitPageNavigationController.modalPresentationStyle = .overFullScreen
        unitPageNavigationController.modalTransitionStyle = .crossDissolve
        
        navigationController.present(unitPageNavigationController, animated: true, completion: nil)
    }
    
    func finish(with child: Coordinator?) {
        for (index, coordinator) in
            childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
