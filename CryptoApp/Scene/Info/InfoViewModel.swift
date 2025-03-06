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
        let popularReslut: Driver<PopularEntity?>
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
        let popularResult: BehaviorRelay<PopularEntity?> = BehaviorRelay(value: nil)
        
        input.reloadTrigger
            .withUnretained(self)
            .flatMapLatest { _ in
                return self.service.getTrending()
                    .catch { error in
                        return Observable.just(PopularEntity(coins: [], nfts: []))
                    }
            }
            .bind(with: self) { onwer, data in
                popularResult.accept(data)
            }
            .disposed(by: disposeBag)
        
        return Output(
            popularReslut: popularResult.asDriver()
        )
    }
    
}
