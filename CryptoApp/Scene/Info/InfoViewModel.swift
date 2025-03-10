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
        let reloadTrigger: BehaviorRelay<Void>
    }
    
    struct Output {
        let errorResult: Driver<CoingeckoError>
        let timeStamp: BehaviorRelay<Date>
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
        let timeStamp: BehaviorRelay<Date> = BehaviorRelay(value: Date())
        let coinResult: BehaviorRelay<[PopularCoinEntity]> = BehaviorRelay(value: [])
        let nftsResult: BehaviorRelay<[PopularNftsEntity]> = BehaviorRelay(value: [])
        let errorResult: PublishRelay<CoingeckoError> = PublishRelay()
        
        input.reloadTrigger
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                return owner.service.getTrending()
                    .catch { error in
                        if let geckoError = error as? CoingeckoError {
                            errorResult.accept(geckoError)
                        } else {
                            errorResult.accept(.decoding)
                        }
                        return Observable.just(PopularEntity(coins: [], nfts: []))
                    }
            }
            .map {
                let coinData = Array($0.coins.prefix(14))
                let nftsData = Array($0.nfts.prefix(7))
                return PopularEntity(coins: coinData, nfts: nftsData)
            }
            .bind { data in
                timeStamp.accept(Date())
                coinResult.accept(data.coins)
                nftsResult.accept(data.nfts)
            }
            .disposed(by: disposeBag)
        
        return Output(
            errorResult: errorResult.asDriver(onErrorJustReturn: CoingeckoError.decoding),
            timeStamp: timeStamp,
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
