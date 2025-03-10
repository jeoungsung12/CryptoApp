//
//  SearchTableViewModel.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/9/25.
//

import Foundation
import RxSwift
import RxCocoa

protocol ToastDelegate: AnyObject {
    func toastMessage(_ message: String)
}

final class SearchTableViewModel: BaseViewModel {
    private let realmRepository: RealmRepositoryType = RealmRepository()
    private var disposeBag = DisposeBag()
    
    weak var delegate: ToastDelegate?
    struct Input {
        let starStateTrigger: BehaviorRelay<String>
        let starTrigger: ControlEvent<Void>
    }
    
    struct Output {
        let starBtnResult: Driver<RealmEntity>
    }
    
    init() {
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
}

extension SearchTableViewModel {
    
    func transform(_ input: Input) -> Output {
        let starBtnResult: BehaviorRelay<RealmEntity> = BehaviorRelay(value: RealmEntity(bool: false, message: ""))
        
        input.starStateTrigger
            .withUnretained(self)
            .flatMapLatest { owner, coinId in
                let state = owner.realmRepository.getState(coinId)
                return Observable.just(RealmEntity(bool: state, message: ""))
            }
            .bind(to: starBtnResult)
            .disposed(by: disposeBag)
        
        input.starTrigger
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                let bool = starBtnResult.value.bool
                let coinId = input.starStateTrigger.value
                let result = (bool) ? owner.realmRepository.deleteItem(coinId) : owner.realmRepository.addItem(coinId)
                owner.delegate?.toastMessage(coinId + result.description)
                switch result {
                case .add:
                    return Observable.just(RealmEntity(bool: true, message: result.description))
                case .delete:
                    return Observable.just(RealmEntity(bool: false, message: result.description))
                case .error:
                    return Observable.just(RealmEntity(bool: bool, message: result.description))
                }
            }
            .bind(to: starBtnResult)
            .disposed(by: disposeBag)
        
        return Output(
            starBtnResult: starBtnResult.asDriver(onErrorJustReturn: RealmEntity(bool: false, message: ""))
        )
    }
    
}
