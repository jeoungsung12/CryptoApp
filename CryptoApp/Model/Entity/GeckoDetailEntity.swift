//
//  GeckoCoinEntity.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation
struct GeckoDetailEntity {
    let id: String
    let name: String
    let image: String
    let price: Double
    let percent: Double
    let chartData: [Double]
    let lastUpdated: String
    
    let high24: Double
    let low24: Double
    let allTimeHigh: Double
    let allTimeLow: Double
    let highDate: String
    let lowDate: String
    
    let marketCap: Double
    let fdvValue: Double
    let volume: Double
    
    func toHeaderEntity() -> DetailHeaderEntity {
        return DetailHeaderEntity(
            price: price,
            percent: percent,
            chartData: chartData,
            lastUpdated: lastUpdated
        )
    }
    
    func toMiddleEntity() -> DetailMiddleEntity {
        return DetailMiddleEntity(
            high24: high24,
            low24: low24,
            allTimeHigh: allTimeHigh,
            allTimeLow: allTimeLow,
            highDate: highDate,
            lowDate: lowDate
        )
    }
    
    func toFooterEntity() -> DetailFooterEntity {
        return DetailFooterEntity(
            marketCap: marketCap,
            fdvValue: fdvValue,
            volume: volume
        )
    }
}

struct DetailHeaderEntity {
    let price: Double
    let percent: Double
    let chartData: [Double]
    let lastUpdated: String
}

struct DetailMiddleEntity {
    let high24: Double
    let low24: Double
    let allTimeHigh: Double
    let allTimeLow: Double
    let highDate: String
    let lowDate: String
}

struct DetailFooterEntity {
    let marketCap: Double
    let fdvValue: Double
    let volume: Double
}

extension GeckoDetailResponseDTO {
    func toEntity() -> GeckoDetailEntity {
        return GeckoDetailEntity(
            id: id,
            name: name,
            image: image,
            price: currentPrice,
            percent: priceChangePercentage24H,
            chartData: sparkline.price,
            lastUpdated: lastUpdated,
            high24: high24H,
            low24: low24H,
            allTimeHigh: ath,
            allTimeLow: atl,
            highDate: athDate,
            lowDate: atlDate,
            marketCap: marketCap,
            fdvValue: fullyDilutedValuation,
            volume: totalVolume
        )
    }
}
