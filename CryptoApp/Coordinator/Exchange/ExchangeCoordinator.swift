//
//  ExchangeCoordinator.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/10/25.
//

import UIKit

final class ExchangeCoordinator: NavigationCoordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let exchangeVC = ExchangeViewController()
        exchangeVC.coordinator = self
        navigationController.viewControllers = [exchangeVC]
    }
    
}
