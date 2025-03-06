//
//  TabBarController.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }
    
    private func configureTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        appearance.selectionIndicatorTintColor = .black
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
        
        self.selectedIndex = 0
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .darkGray
        
        let firstVC = UINavigationController(rootViewController: ExchangeViewController())
        let secondVC = UINavigationController(rootViewController: InfoViewController())
        let thridVC = UINavigationController(rootViewController: PortfolioViewController())
        
        self.setViewControllers([firstVC, secondVC, thridVC], animated: true)
        guard let items = self.tabBar.items else { return }
        items[0].image = .chartLine
        items[1].image = .chartBar
        items[2].image = .star
        
        items[0].title = "거래소"
        items[1].title = "코인정보"
        items[2].title = "포트폴리오"
    }
    
    deinit {
        print(#function, self)
    }
    
}
