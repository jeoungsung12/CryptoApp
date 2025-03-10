//
//  TabBarController.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit

final class TabBarController: UITabBarController {
    
    weak var coordinator: TabBarCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        print(#function)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        appearance.selectionIndicatorTintColor = .black
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
        
        self.selectedIndex = 0
        self.tabBar.shadowImage = nil
        self.tabBar.tintColor = .customDarkGray
        self.tabBar.unselectedItemTintColor = .darkGray
        
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
