//
//  ExchangeButtonEntity.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/8/25.
//

import Foundation

struct ExchangeButtonEntity {
    var type: ExchangeButtonType
    var state: ExchangeButtonState
    
    enum ExchangeButtonType: CaseIterable {
        case current
        case previous
        case amount
    }
    
    enum ExchangeButtonState {
        case none
        case up
        case down
        
        func configureButtonType(_ tag: Int) -> ExchangeButtonType {
            return ExchangeButtonType.allCases[tag]
        }
        
        func configureType() -> ExchangeButtonState {
            switch self {
            case .none:
                return .down
            case .up:
                return .none
            case .down:
                return .up
            }
        }
    }
}
