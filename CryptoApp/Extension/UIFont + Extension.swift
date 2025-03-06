//
//  UIFont.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit

extension UIFont {
    static let largeBold: UIFont = {
        return .boldSystemFont(ofSize: 12)
    }()
    
    static let largeRegular: UIFont = {
        return .systemFont(ofSize: 12, weight: .regular)
    }()
    
    static let smallBold: UIFont = {
        return .boldSystemFont(ofSize: 9)
    }()
    
    static let smallRegular: UIFont = {
        return .systemFont(ofSize: 9, weight: .regular)
    }()
}
