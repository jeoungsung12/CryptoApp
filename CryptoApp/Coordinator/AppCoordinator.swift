//
//  AppCoordinator.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarCoord = TabBarCoordinator(navigationController: navigationController)
        childCoordinators.append(tabBarCoord)
        tabBarCoord.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    deinit {
        print(#function, self)
    }
}
