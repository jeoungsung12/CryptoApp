//
//  ViewController + Extension.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit

extension UIViewController {
    
    func setNavigation(title: String? = nil, backTitle: String? = nil, backImage: UIImage? = .arrowleft, color: UIColor = .customDarkGray) {
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = color
        titleLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        let titleItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = titleItem
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        appearance.titleTextAttributes = [.foregroundColor: color]
        
        navigationBar.tintColor = color
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationItem.backButtonDisplayMode = .minimal
    }
    
}
