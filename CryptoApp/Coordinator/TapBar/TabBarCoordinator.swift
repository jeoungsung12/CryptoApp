//
//  TabBarCoordinator.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/10/25.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = TabBarController()
        
        let exchangeNV = UINavigationController()
        let exchangeCoord = ExchangeCoordinator(navigationController: exchangeNV)
        exchangeCoord.start()
        
        let infoNV = UINavigationController()
        let infoCoord = InfoCoordinator(navigationController: infoNV)
        infoCoord.start()
        
        let portfolioNV = UINavigationController()
        let portfolioCoord = PortfolioCoordinator(navigationController: portfolioNV)
        portfolioCoord.start()
        
        childCoordinators = [exchangeCoord, infoCoord, portfolioCoord]
        tabBarController.viewControllers = [exchangeNV, infoNV, portfolioNV]
        tabBarController.coordinator = self
        tabBarController.configureTabBar()
        navigationController.viewControllers = [tabBarController]
        self.navigationController.navigationBar.isHidden = true
    }
    
    deinit {
        print(#function, self)
    }
}
