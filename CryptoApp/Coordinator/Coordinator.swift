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
    func pop(_ coordinator: Coordinator)
}

extension NavigationCoordinator {
    
    func push(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func pop(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 !== coordinator }
    }

}
