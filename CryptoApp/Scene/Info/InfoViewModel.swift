//
//  InfoViewModel.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation
import RxSwift
import RxCocoa

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
            .flatMapLatest { owner, _ in
                return owner.service.getTrending()
                    .catch { error in
                        return Observable.just(PopularEntity(coins: [], nfts: []))
                    }
            }
            .bind { data in
                coinResult.accept(data.coins)
                nftsResult.accept(data.nfts)
            }
            .disposed(by: disposeBag)
        
        return Output(
            coinResult: coinResult.asDriver(),
            nftsResult: nftsResult.asDriver()
        )
    }
    
    func isValidSearchText(_ text: String?) -> String? {
        guard var text = text else { return nil }
        text.removeAll { $0 == " " }
        return (text.count >= 1) ? text : nil
    }
}
