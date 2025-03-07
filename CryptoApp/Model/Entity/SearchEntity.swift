//
//  SearchEntity.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import Foundation

struct SearchEntity {
    let id: String
    let name: String
    let symbol: String
    let rank: Int
    let thumb: String
}

extension GeckoSearchResponseDTO {
    func toEntity() -> [SearchEntity] {
        return coins.map {
            SearchEntity(
                id: $0.id,
                name: $0.name,
                symbol: $0.symbol,
                rank: $0.marketCapRank,
                thumb: $0.thumb
            )
        }
    }
}
