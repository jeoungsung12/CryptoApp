//
//  GeckoCoinEntity.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit

struct GeckoDetailEntity {
    //header
    let id: String
    let name: String
    let image: String
    let price: Double
    let percent: Double
    let chartData: [Double]
    let lastUpdated: String
    //middle
    let high24: Double
    let low24: Double
    let allTimeHigh: Double
    let allTimeLow: Double
    let highDate: String
    let lowDate: String
    //footer
    let marketCap: Double
    let fdvValue: Double
    let volume: Double
    
    func toHeaderEntity() -> DetailHeaderEntity {
        return DetailHeaderEntity(
            price: .convertNumber(.dToS, value: price),
            percent: .convertNumber(.dToS, value: percent) + "%",
            chartData: chartData,
            lastUpdated: .dateToString(.detailChart, dateString: lastUpdated),
            color: .stringColor(percent)
        )
    }
    
    func toMiddleEntity() -> DetailMiddleEntity {
        return DetailMiddleEntity(
            high24: "₩" + .convertNumber(.dToS, value: high24),
            low24: "₩" + .convertNumber(.dToS, value: low24),
            allTimeHigh: "₩" + .convertNumber(.dToS, value: allTimeHigh),
            allTimeLow: "₩" + .convertNumber(.dToS, value: allTimeLow),
            highDate: .dateToString(.detailATD, dateString: highDate),
            lowDate: .dateToString(.detailATD, dateString: lowDate)
        )
    }
    
    func toFooterEntity() -> DetailFooterEntity {
        return DetailFooterEntity(
            marketCap: .convertNumber(.dToS, value: marketCap),
            fdvValue: .convertNumber(.dToS, value: fdvValue),
            volume: .convertNumber(.dToS, value: volume)
        )
    }
}

struct DetailHeaderEntity {
    let price: String
    let percent: String
    let chartData: [Double]
    let lastUpdated: String
    let color: UIColor
}

struct DetailMiddleEntity {
    let high24: String
    let low24: String
    let allTimeHigh: String
    let allTimeLow: String
    let highDate: String
    let lowDate: String
}

struct DetailFooterEntity {
    let marketCap: String
    let fdvValue: String
    let volume: String
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
