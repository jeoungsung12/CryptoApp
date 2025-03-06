//
//  ExchangeEntity.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation

struct ExchangeEntity {
    let marketName: String
    let currentPrice: Double
    let tradeVolume: Double
    let changePrice: Double
    let changePercent: Double
    
    //TODO: 소숫점자리 구분
}

extension UpbitResponseDTO {
    func toEntity() -> ExchangeEntity {
        return ExchangeEntity(
            marketName: market,
            currentPrice: tradePrice,
            tradeVolume: accTradeVolume24H,
            changePrice: signedChangePrice,
            changePercent: signedChangeRate
        )
    }
}
