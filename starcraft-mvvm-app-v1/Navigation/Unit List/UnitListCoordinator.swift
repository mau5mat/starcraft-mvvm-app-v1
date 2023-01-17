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
        self.units = units
    }
    
    func start() {
        let viewModel = UnitListViewModel(units: units)
        
        let viewController = UnitListViewController.instantiate(storyboard: "UnitList")
        viewController.loadingService = LoadingService()
        viewController.dialogueService = DialogueService()
        viewController.viewModel = viewModel
        viewController.navigation = self
        
        viewController.navigationItem.largeTitleDisplayMode = .never
    
        navigationController.pushViewController(viewController, animated: true)
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

protocol UnitListNavigationDelegate: AnyObject {
    func showUnitPage(with unit: SCUnit)
}

extension UnitListCoordinator: UnitListNavigationDelegate {
    func showUnitPage(with unit: SCUnit) {
        let coordinator = UnitPageCoordinator(navigationController: navigationController, unit: unit)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
