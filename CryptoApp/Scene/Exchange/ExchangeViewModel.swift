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
    private let service = UpbitService()
    private var disposeBag = DisposeBag()
    
    struct Input {
        let typeTrigger: PublishRelay<[ExchangeButtonEntity.ExchangeButtonState]>
        let reloadTrigger: BehaviorRelay<ExchangeButtonEntity>
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
        
        input.typeTrigger
            .map { state in
                state.allSatisfy {
                    $0 == .none
                }
            }
            .bind(with: self) { owner, valid in
                if valid {
                    input.reloadTrigger.accept(ExchangeButtonEntity(type: .amount, state: .none))
                }
            }
            .disposed(by: disposeBag)
        
        input.reloadTrigger
            .withUnretained(self)
            .flatMapLatest { owner, type in
                return owner.service.getAllCoin()
                    .catch { error in
                        return Observable.just([])
                    }
                    .map { owner.sortedExchange(type, $0) }
            }
            .bind(with: self) { owner, value in
                coinResult.accept(value)
            }
            .disposed(by: disposeBag)
        
        return Output(
            coinResult: coinResult.asDriver()
        )
    }
    
    private func sortedExchange(_ entity: ExchangeButtonEntity,_ data: [UpbitResponseDTO]) -> [ExchangeEntity] {
        switch entity.type {
        case .current:
            return data.sorted(by: { left, right in
                switch entity.state {
                case .up:
                    return left.tradePrice < right.tradePrice
                case .none, .down:
                    return left.tradePrice > right.tradePrice
                }
            }).map { $0.toEntity() }
            
        case .previous:
            return data.sorted(by: { left, right in
                switch entity.state {
                case .up:
                    return left.signedChangeRate < right.signedChangeRate
                case .none, .down:
                    return left.signedChangeRate > right.signedChangeRate
                }
            }).map { $0.toEntity() }
            
        case .amount:
            return data.sorted(by: { left, right in
                switch entity.state {
                case .up:
                    return left.accTradePrice24H < right.accTradePrice24H
                case .none, .down:
                    return left.accTradePrice24H > right.accTradePrice24H
                }
            }).map { $0.toEntity() }
            
        }
    }
    
    func timerExchange(_ states: [ExchangeButtonEntity.ExchangeButtonState], _ entity: ExchangeButtonEntity,_ input: ExchangeViewModel.Input) {
        print(#function)
        if states.allSatisfy({ $0 == .none }) {
            input.reloadTrigger.accept(ExchangeButtonEntity(type: .amount, state: .none))
        } else {
            input.reloadTrigger.accept(ExchangeButtonEntity(type: entity.type, state: entity.state))
        }
    }
    
}
