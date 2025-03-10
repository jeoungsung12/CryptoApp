//
//  ProfileCoordinator.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/10/25.
//

import UIKit

final class PortfolioCoordinator: NavigationCoordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let portVC = PortfolioViewController()
        portVC.coordinator = self
        navigationController.viewControllers = [portVC]
    }
    
    deinit {
        print(#function, self)
    }
}
