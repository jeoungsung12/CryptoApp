//
//  String + Extension.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation

enum DateFormatType {
    case info
    case detailChart
    case detailATD
}

enum DoubleToStringType {
    case dToS
    case sToS
    case currentPrice
    case percent
    case tradeVolume
}

extension String {
    
    static func splitReplaceString(_ market: String) -> String {
        let (symbol) = market.split(separator: "-")
        return symbol[1] + "/" + symbol[0]
    }
    
    static func dateToString(_ type: DateFormatType, dateString: String = "", date: Date = Date()) -> String {
        let formatter = DateFormatter()
        switch type {
        case .info:
            formatter.dateFormat = "MM.dd HH:mm 기준"
            return formatter.string(from: date)
        case .detailChart:
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            formatter.timeZone = TimeZone(abbreviation: "UTC")
            guard let date = formatter.date(from: dateString) else { return dateString }
            formatter.dateFormat = "M/dd HH:mm:ss 업데이트"
            return formatter.string(from: date)
        case .detailATD:
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            formatter.timeZone = TimeZone(abbreviation: "UTC")
            guard let date = formatter.date(from: dateString) else { return dateString }
            formatter.dateFormat = "yy년 M월 dd일"
            return formatter.string(from: date)
        }
    }
    
    static func convertNumber(_ type: DoubleToStringType, value: Any) -> String {
            var num: Double = 0.0
            
            if let doubleValue = value as? Double {
                num = doubleValue
            } else if let stringValue = value as? String, let doubleValue = Double(stringValue) {
                num = doubleValue
            } else {
                return ""
            }
            
            if (num.isZero) && (type != .percent) { return "0" }
            switch type {
            case .dToS, .sToS:
                return num == Double(Int(num)) ? Int(num).formatted() : String(format: "%.2f", num)
                
            case .currentPrice:
                if (num == Double(Int(num)) && String(Int(num)).count >= 4 ) {
                    return Int(num).formatted()
                }
                let formatted = String(format: "%.2f", num)
                return (formatted.last == "0") ? String(format: "%.1f", num) : formatted
                
            case .percent:
                return String(format: "%.2f", num)
                
            case .tradeVolume:
                let decimal = Int(pow(10.0, 6.0))
                let intNum = Int(num)
                return intNum < decimal ? intNum.formatted() : "\((intNum / decimal).formatted())백만"
            }
        }

}
