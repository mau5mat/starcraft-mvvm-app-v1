//
//  UnitListCoordinator.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import UIKit

class UnitListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var units: [SCUnit]
    
    init(navigationController: UINavigationController, units: [SCUnit]) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
        
        self.units = units
    }
    
    func start() {
        let viewModel = UnitListViewModel(units: units)
        
        let viewController = UnitListViewController.instantiate(storyboard: "UnitList")
        viewController.viewModel = viewModel
        viewController.navigation = self 
        viewController.loadingService = LoadingService()
        viewController.dialogueService = DialogueService()
    
        navigationController.pushViewController(viewController, animated: false)
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

protocol UnitListNavigation {
    func showUnitPage(with unit: SCUnit)
}

extension UnitListCoordinator: UnitListNavigation {
    func showUnitPage(with unit: SCUnit) {
        let coordinator = UnitPageCoordinator(navigationController: navigationController, unit: unit)
        self.childCoordinators.append(coordinator)
        coordinator.start()
    }
}
