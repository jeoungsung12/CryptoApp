//
//  GeckoPopularEntity.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit

struct PopularEntity {
    let coins: [PopularCoinEntity]
    let nfts: [PopularNftsEntity]
}

struct PopularCoinEntity {
    let id: String
    let name: String
    let image: String
    let symbol: String
    let volumePercent: String
    let color: UIColor
}


struct PopularNftsEntity {
    let id: String
    let name: String
    let image: String
    let volumePercent: String
    let volumePrice: String
    let color: UIColor
}

extension GeckoPopularResponseDTO {
    
    func toCoinEntity() -> PopularEntity {
        let coins = coins.map {
             PopularCoinEntity(
                id: $0.item.id,
                name: $0.item.name,
                image: $0.item.thumb ?? "이미지 준비중!",
                symbol: $0.item.symbol,
                volumePercent: .convertNumber(.dToS, value: $0.item.data.changePercent24th.krw) + "%",
                color: .stringColor($0.item.data.changePercent24th.krw)
            )
        }
        
        let nfts = nfts.map {
            PopularNftsEntity(
                id: $0.id,
                name: $0.name,
                image: $0.thumb ?? "이미지 준비중!",
                volumePercent: .convertNumber(.sToS, value: $0.data.floorPriceInUsd24HPercentageChange) + "%",
                volumePrice: $0.data.floorPrice,
                color: .stringColor(Double($0.data.floorPriceInUsd24HPercentageChange) ?? 0.0)
            )
        }
        
        return PopularEntity(coins: coins, nfts: nfts)
    }
    
    
}
