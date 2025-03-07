//
//  GeckoSearchResponseDTO.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import Foundation

struct GeckoSearchResponseDTO: Decodable {
    let coins: [SearchDTO]
}

struct SearchDTO: Decodable {
    let id, name, apiSymbol, symbol: String
    let marketCapRank: Int
    let thumb, large: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case apiSymbol = "api_symbol"
        case symbol
        case marketCapRank = "market_cap_rank"
        case thumb, large
    }
}
