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
            marketName: .splitReplaceString(market),
            currentPrice: .convertNumber(.currentPrice, value: tradePrice),
            tradeVolume: .convertNumber(.tradeVolume, value: accTradePrice24H),
            changePrice: .convertNumber(.dToS, value: signedChangePrice),
            changePercent: .convertNumber(.dToS, value: signedChangeRate * 100) + "%",
            color: .stringColor(signedChangeRate)
        )
    }
}
