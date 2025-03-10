//
//  Coordinator.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/10/25.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get }
    
    func push(_ coordinator: Coordinator)
    func pop()
}

extension NavigationCoordinator {
    
    func push(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
        
        if let lastCoordinator = childCoordinators.last {
            childCoordinators.removeLast()
        }
    }
}
