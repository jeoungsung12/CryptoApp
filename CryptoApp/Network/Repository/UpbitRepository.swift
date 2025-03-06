//
//  UpbitRepository.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation
import RxSwift
import RxCocoa

protocol UpbitRepositoryType {
    func getAllCoin() -> Observable<[UpbitResponseDTO]>
}

final class UpbitRepository: UpbitRepositoryType {
    
    func getAllCoin() -> Observable<[UpbitResponseDTO]> {
        return NetworkManager.shared.getData(UpbitRouter.getAllCoin)
    }
    
}
