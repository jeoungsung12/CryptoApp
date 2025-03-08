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
        
        input.reloadTrigger
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                return owner.service.getTrending()
                    .catch { error in
                        return Observable.just(PopularEntity(coins: [], nfts: []))
                    }
            }
            .bind { data in
                timeStamp.accept(Date())
                coinResult.accept(data.coins)
                nftsResult.accept(data.nfts)
            }
            .disposed(by: disposeBag)
        
        return Output(
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
    
    func checkTimer(_ previousTime: Date, _ input: Input) {
        let difference = Calendar.current.dateComponents([.minute], from: previousTime, to: Date())
        if let minute = difference.minute, minute >= 10 {
            input.reloadTrigger.accept(())
        } else { return }
    }
}
