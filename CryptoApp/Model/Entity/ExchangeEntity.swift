//
//  ExchangeEntity.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit

struct ExchangeEntity {
    let marketName: String
    let currentPrice: String
    let tradeVolume: String
    let changePrice: String
    let changePercent: String
    let color: UIColor
}

extension UpbitResponseDTO {
    func toEntity() -> ExchangeEntity {
        return ExchangeEntity(
            marketName: market,
            currentPrice: .currentToString(tradePrice),
            tradeVolume: .amountToString(accTradePrice24H),
            changePrice: .doubleToString(signedChangePrice),
            changePercent: .doubleToString(signedChangeRate * 100) + "%",
            color: .stringColor(signedChangeRate)
        )
    }
}
