//
//  PortfolioViewController.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit

final class PortfolioViewController: UIViewController {
    
    weak var coordinator: PortfolioCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
}
