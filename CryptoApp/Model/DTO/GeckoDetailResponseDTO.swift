//
//  GeckoCoinResponseDTO.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation

struct GeckoDetailResponseDTO: Decodable {
    let id, symbol, name, image, athDate, atlDate, lastUpdated: String
    let currentPrice, marketCap, marketCapRank, fullyDilutedValuation: Double
    let totalVolume, high24H, low24H, priceChange24H, priceChangePercentage24H: Double
    let marketCapChange24H, marketCapChangePercentage24H: Double
    let circulatingSupply, totalSupply, ath, athChangePercentage: Double
    let atl, atlChangePercentage: Double
    let roi: String?
    let maxSupply: Double?
    let sparkline: Sparkline
    
    struct Sparkline: Decodable {
        let price: [Double]
    }
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi
        case lastUpdated = "last_updated"
        case sparkline = "sparkline_in_7d"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        self.currentPrice = try container.decode(Double.self, forKey: .currentPrice)
        self.marketCap = try container.decode(Double.self, forKey: .marketCap)
        self.marketCapRank = try container.decode(Double.self, forKey: .marketCapRank)
        self.fullyDilutedValuation = try container.decode(Double.self, forKey: .fullyDilutedValuation)
        self.totalVolume = try container.decode(Double.self, forKey: .totalVolume)
        self.high24H = try container.decode(Double.self, forKey: .high24H)
        self.low24H = try container.decode(Double.self, forKey: .low24H)
        self.priceChange24H = try container.decode(Double.self, forKey: .priceChange24H)
        self.priceChangePercentage24H = try container.decode(Double.self, forKey: .priceChangePercentage24H)
        self.marketCapChange24H = try container.decode(Double.self, forKey: .marketCapChange24H)
        self.marketCapChangePercentage24H = try container.decode(Double.self, forKey: .marketCapChangePercentage24H)
        self.circulatingSupply = try container.decode(Double.self, forKey: .circulatingSupply)
        self.totalSupply = try container.decode(Double.self, forKey: .totalSupply)
        self.ath = try container.decode(Double.self, forKey: .ath)
        self.athChangePercentage = try container.decode(Double.self, forKey: .athChangePercentage)
        self.athDate = try container.decode(String.self, forKey: .athDate)
        self.atl = try container.decode(Double.self, forKey: .atl)
        self.atlChangePercentage = try container.decode(Double.self, forKey: .atlChangePercentage)
        self.atlDate = try container.decode(String.self, forKey: .atlDate)
        self.lastUpdated = try container.decode(String.self, forKey: .lastUpdated)
        self.sparkline = try container.decode(GeckoDetailResponseDTO.Sparkline.self, forKey: .sparkline)
        
        
        self.maxSupply = try container.decodeIfPresent(Double.self, forKey: .maxSupply) ?? 0.0
        self.roi = try container.decodeIfPresent(String.self, forKey: .roi) ?? ""
    }
}
