//
//  Color + Extension.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import UIKit

extension UIColor {
    
    static func stringColor(_ percent: Double) -> UIColor {
        if percent.isZero { return .customDarkGray }
        return (percent < 0) ? .customBlue : .customRed
    }
    
}
