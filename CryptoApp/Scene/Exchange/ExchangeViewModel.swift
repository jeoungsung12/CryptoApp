//
//  ExchangeViewModel.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation
import RxSwift
import RxCocoa

final class ExchangeViewModel: BaseViewModel {
    private let service = UpbitService(repository: UpbitRepository())
    private var disposeBag = DisposeBag()
    
    struct Input {
        let reloadTrigger: PublishRelay<Void>
    }
    
    struct Output {
        let coinResult: Driver<[ExchangeEntity]>
    }
    
    init() {
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
    
}

extension ExchangeViewModel {
    
    func transform(_ input: Input) -> Output {
        let coinResult: BehaviorRelay<[ExchangeEntity]> = BehaviorRelay(value: [])
        
        input.reloadTrigger
            .withUnretained(self)
            .flatMapLatest { _ in
                return self.service.getAllCoin()
                    .catch { error in
                        return
                    }
            }
            .bind { value in
                coinResult.accept(value)
            }
            .disposed(by: disposeBag)
        
        
        return Output(
            coinResult: coinResult.asDriver()
        )
    }
    
}
