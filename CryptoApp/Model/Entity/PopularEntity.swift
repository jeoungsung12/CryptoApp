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
    let image: String
    let symbol: String
    let volumePercent: String
}


struct PopularNftsEntity {
    let id: String
    let name: String
    let image: String
    let volumePercent: String
    let volumePrice: String
}

extension GeckoPopularResponseDTO {
    
    func toCoinEntity() -> PopularEntity {
        let coins = coins.map {
             PopularCoinEntity(
                id: $0.item.id,
                name: $0.item.name,
                image: $0.item.thumb ?? "이미지 준비중!",
                symbol: $0.item.symbol,
                volumePercent: .doubleToString(0.0)
                //TODO: 수정
            )
        }
        
        let nfts = nfts.map {
            PopularNftsEntity(
                id: $0.id,
                name: $0.name,
                image: $0.thumb ?? "이미지 준비중!",
                volumePercent: $0.data.floorPrice,
                volumePrice: $0.data.floorPriceInUsd24HPercentageChange
            )
        }
        
        return PopularEntity(coins: coins, nfts: nfts)
    }
    
    
}
