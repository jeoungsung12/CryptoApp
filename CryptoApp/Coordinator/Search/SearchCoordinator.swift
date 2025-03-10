//
//  SearchCoordinator.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/10/25.
//

import UIKit

final class SearchCoordinator: NavigationCoordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let coinName: String
    
    init(navigationController: UINavigationController, coinName: String) {
        self.navigationController = navigationController
        self.coinName = coinName
    }
    
    func start() {
        let searchVM = SearchViewModel(coinName: coinName)
        let searchVC = SearchViewController(viewModel: searchVM)
        navigationController.pushViewController(searchVC, animated: true)
        searchVC.coordinator = self
    }
    
    func pushDetail(_ coinId: String) {
        let detailCoord = DetailCoordinator(navigationController: navigationController, coinId: coinId)
        push(detailCoord)
    }
    
    func popChild() {
        pop(self)
    }
    
    deinit {
        print(#function, self)
    }
}
