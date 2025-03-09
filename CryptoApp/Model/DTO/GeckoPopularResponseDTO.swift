//
//  GeckoPopularResponseDTO.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation

struct GeckoPopularResponseDTO: Decodable {
    let coins: [PopularCoinsDTO]
    let nfts: [PopularNftsDTO]
}

struct PopularCoinsDTO: Decodable {
    let item: PopularItemDTO
    
    struct PopularItemDTO: Decodable {
        let id: String
        let coin_id: Int
        let name: String
        let symbol: String
        let market_cap_rank: Int
        let thumb: String?
        let small: String
        let large: String
        let slug: String
        let price_btc: Double
        let score: Int
        let data: PopularDataDTO
    }

    struct PopularDataDTO: Decodable {
        let price: Double
        let priceBtc: String
        let changePercent24th: PopularChangePercent
        
        enum CodingKeys: String, CodingKey {
            case price
            case priceBtc = "price_btc"
            case changePercent24th = "price_change_percentage_24h"
        }
    }

    struct PopularChangePercent: Decodable {
        let krw: Double
    }
}


struct PopularNftsDTO: Decodable {
    let id, name, symbol: String
    let thumb: String?
    let nftContractID: Int
    let nativeCurrencySymbol: String
    let floorPriceInNativeCurrency, floorPrice24HPercentageChange: Double
    let data: PopularDataDTO
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, thumb
        case nftContractID = "nft_contract_id"
        case nativeCurrencySymbol = "native_currency_symbol"
        case floorPriceInNativeCurrency = "floor_price_in_native_currency"
        case floorPrice24HPercentageChange = "floor_price_24h_percentage_change"
        case data
    }
    
    struct PopularDataDTO: Decodable {
        let floorPrice, floorPriceInUsd24HPercentageChange, h24Volume, h24AverageSalePrice: String
        let sparkline: String
        
        enum CodingKeys: String, CodingKey {
            case floorPrice = "floor_price"
            case floorPriceInUsd24HPercentageChange = "floor_price_in_usd_24h_percentage_change"
            case h24Volume = "h24_volume"
            case h24AverageSalePrice = "h24_average_sale_price"
            case sparkline
        }
    }
    
}
