//
//  UIImage + Extension.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit

extension UIImage {
    
    static var arrowUp: UIImage? = {
        return .init(systemName: "arrowtriangle.up.fill")
    }()
    
    static var arrowDown: UIImage? = {
        return .init(systemName: "arrowtriangle.down.fill")
    }()
    
    static var arrowRight: UIImage? = {
        return .init(systemName: "chevron.right")
    }()
    
    static var arrowleft: UIImage? = {
        return .init(systemName: "arrow.left")
    }()
    
    static var searchIcon: UIImage? = {
        return .init(systemName: "magnifyingglass")
    }()
    
    static var starFill: UIImage? = {
        return .init(systemName: "star.fill")
    }()
    
    static var star: UIImage? = {
        return .init(systemName: "star")
    }()
    
    static var chartBar: UIImage? = {
        return .init(systemName: "chart.bar.fill")
    }()
    
    static var chartLine: UIImage? = {
        return .init(systemName: "chart.line.uptrend.xyaxis")
    }()
    
}
