//
//  DetailCoordinator.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/10/25.
//

import UIKit

final class DetailCoordinator: NavigationCoordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let coinId: String
    
    init(navigationController: UINavigationController, coinId: String) {
        self.navigationController = navigationController
        self.coinId = coinId
    }
    
    func start() {
        let detailVM = CoinDetailViewModel(coinId: coinId)
        let detailVC = CoinDetailViewController(viewModel: detailVM)
        detailVC.coordinator = self
        navigationController.pushViewController(detailVC, animated: true)
    }
}
