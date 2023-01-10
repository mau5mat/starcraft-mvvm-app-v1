//
//  MainCoordinator.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        let viewModel = MainViewModel(responseService: EndpointResponseService(networkService: NetworkService(), parser: DataParser()))
        
        let viewController = MainViewController.instantiate(storyboard: "Main")
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

protocol MainNavigation {
    func showUnitListPage(with units: [SCUnit])
}

extension MainCoordinator: MainNavigation {
    func showUnitListPage(with units: [SCUnit]) {
        let coordinator = UnitListCoordinator(navigationController: navigationController, units: units)
        self.childCoordinators.append(coordinator)
        coordinator.start()
    }
}