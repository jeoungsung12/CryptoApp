//
//  ErrorViewModel.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/9/25.
//

import Foundation
import RxSwift
import RxCocoa

enum ErrorSenderType: String {
    case exchange
    case info
    case search
    case detail
    case network = "네트워크 통신이 원활하지 않습니다."
}

protocol ErrorDelegate: AnyObject {
    func reloadNetwork(type: ErrorSenderType)
}

final class ErrorViewModel: BaseViewModel {
    private var disposeBag = DisposeBag()
    
    var notiType: ErrorSenderType
    weak var delegate: ErrorDelegate?
    struct Input {
        let reloadTrigger: ControlEvent<Void>
    }
    
    struct Output {
        let networkReloadTrigger: Driver<Bool>
    }
    
    init(notiType: ErrorSenderType) {
        self.notiType = notiType
    }
}

extension ErrorViewModel {
    
    func transform(_ input: Input) -> Output {
        let networkReload: PublishRelay<Bool> = PublishRelay()
        
        input.reloadTrigger
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                switch owner.notiType {
                case .network:
                    return Observable.just(true)
                default:
                    owner.setDelegate()
                    return Observable.just((false))
                }
            }
            .bind(to: networkReload)
            .disposed(by: disposeBag)
        
        return Output(
            networkReloadTrigger: networkReload.asDriver(onErrorJustReturn: false)
        )
    }
    
    private func setDelegate() {
        delegate?.reloadNetwork(type: notiType)
    }
}
