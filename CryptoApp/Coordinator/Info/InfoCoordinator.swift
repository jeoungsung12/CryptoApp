//
//  InfoCoordnator.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/10/25.
//

import UIKit

final class InfoCoordinator: NavigationCoordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let infoVC = InfoViewController()
        infoVC.coordinator = self
        navigationController.viewControllers = [infoVC]
    }
    
    func pushDetail(_ coinId: String) {
        let detailCoord = DetailCoordinator(navigationController: navigationController, coinId: coinId)
        push(detailCoord)
    }
    
    func pushSearch(_ coinName: String) {
        let searchCoord = SearchCoordinator(navigationController: navigationController, coinName: coinName)
        push(searchCoord)
    }
    
    func popChild() {
        pop(self)
    }
    
    deinit {
        print(#function, self)
    }
}
