//
//  GeckoPopularEntity.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation

struct PopularEntity {
    let coins: [PopularCoinEntity]
    let nfts: [PopularNftsEntity]
}

struct PopularCoinEntity {
    let id: String
    let name: String
    let symbol: String
    let volumePercent: Double
}


struct PopularNftsEntity {
    let id: String
    let name: String
    let volumePercent: String
    let volumePrice: String
}

extension GeckoPopularResponseDTO {
    
    func toCoinEntity() -> PopularEntity {
        let coins = coins.map {
             PopularCoinEntity(
                id: $0.item.id,
                name: $0.item.name,
                symbol: $0.item.symbol,
                volumePercent: 0.0
            )
        }
        
        let nfts = nfts.map {
            PopularNftsEntity(
                id: $0.id,
                name: $0.name,
                volumePercent: $0.data.floorPrice,
                volumePrice: $0.data.floorPriceInUsd24HPercentageChange
            )
        }
        
        return PopularEntity(coins: coins, nfts: nfts)
    }
    
    
}
