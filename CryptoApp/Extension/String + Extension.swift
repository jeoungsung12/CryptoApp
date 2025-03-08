//
//  String + Extension.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation

extension String {
    
    static func splitReplaceString(_ market: String) -> String {
        let (symbol) = market.split(separator: "-")
        return symbol[0] + "/" + symbol[1]
    }
    
    static func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd HH:mm 기준"
        return formatter.string(from: date)
    }
    
    static func doubleToString(_ num: Double) -> String {
        if num.isZero { return "0" }
        if num == Double(Int(num)) {
            return Int(num).formatted()
        } else {
            return String(format: "%.2f", num)
        }
    }
    
    static func stringToString(_ num: String) -> String {
        guard let num = Double(num) else { return "" }
        if num.isZero { return "0" }
        if num == Double(Int(num)) {
            return Int(num).formatted()
        } else {
            return String(format: "%.2f", num)
        }
    }
    
    static func currentToString(_ num: Double) -> String {
        if num == Double(Int(num)) {
            return Int(num).formatted()
        } else {
            let afterNum = String(format: "%.2f", num)
            return (afterNum.last == "0") ? String(format: "%.1f", num) : afterNum
        }
    }
    
    static func amountToString(_ num: Double) -> String {
        let intNum = Int(num)
        let numString = Int(num).formatted()
        let decimal = Int(pow(10.0, 6.0))
        return ((intNum < (decimal) ? numString : "\((intNum / (decimal)).formatted())백만"))
    }
    
}
