//
//  GeckoRepository.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation
import RxSwift
import RxCocoa

protocol GeckoRepositoryType {
    func getCoinDetail(id: String) -> Observable<[GeckoDetailResponseDTO]>
    func getTrending() -> Observable<GeckoPopularResponseDTO>
    func getSearch(text: String) -> Observable<GeckoSearchResponseDTO>
}

final class GeckoRepository: GeckoRepositoryType {
    
    func getCoinDetail(id: String) -> Observable<[GeckoDetailResponseDTO]> {
        return NetworkManager.shared.getData(CoingeckoRouter.getCoinDetail(id: id))
    }
    
    func getTrending() -> Observable<GeckoPopularResponseDTO> {
        return NetworkManager.shared.getData(CoingeckoRouter.getTrending)
    }
    
    func getSearch(text: String) -> Observable<GeckoSearchResponseDTO> {
        return NetworkManager.shared.getData(CoingeckoRouter.getSearch(text: text))
    }
    
}
