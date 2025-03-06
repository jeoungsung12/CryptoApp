//
//  InfoViewModel.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation
import RxSwift
import RxCocoa

enum Section {
    case header
    case footer
}

enum Item {
    case popularSearch
    case popularNFT
}

final class InfoViewModel: BaseViewModel {
    private let service = GeckoService()
    private var disposeBag = DisposeBag()
    
    struct Input {
        let reloadTrigger: PublishRelay<Void>
    }
    
    struct Output {
        let coinResult: Driver<[PopularCoinEntity]>
        let nftsResult: Driver<[PopularNftsEntity]>
    }
    
    init() {
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
}

extension InfoViewModel {
    
    func transform(_ input: Input) -> Output {
        let coinResult: BehaviorRelay<[PopularCoinEntity]> = BehaviorRelay(value: [])
        let nftsResult: BehaviorRelay<[PopularNftsEntity]> = BehaviorRelay(value: [])
        
        input.reloadTrigger
            .withUnretained(self)
            .flatMapLatest { _ in
                return self.service.getTrending()
                    .catch { error in
                        return Observable.just(PopularEntity(coins: [], nfts: []))
                    }
            }
            .bind(with: self) { onwer, data in
                coinResult.accept(data.coins)
                nftsResult.accept(data.nfts)
            }
            .disposed(by: disposeBag)
        
        return Output(
            coinResult: coinResult.asDriver(),
            nftsResult: nftsResult.asDriver()
        )
    }
    
}
