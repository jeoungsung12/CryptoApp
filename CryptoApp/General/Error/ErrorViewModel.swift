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
    case none
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
        let networkReloadTrigger: Driver<Void>
    }
    
    init(notiType: ErrorSenderType) {
        self.notiType = notiType
    }
}

extension ErrorViewModel {
    
    func transform(_ input: Input) -> Output {
        let networkReload: PublishRelay<Void> = PublishRelay()
        
        input.reloadTrigger
            .bind(with: self, onNext: { owner, _ in
                owner.setDelegate()
                networkReload.accept(())
            })
            .disposed(by: disposeBag)
        
        return Output(
            networkReloadTrigger: networkReload.asDriver(onErrorJustReturn: ())
        )
    }
    
    private func setDelegate() {
        delegate?.reloadNetwork(type: notiType)
    }
}
