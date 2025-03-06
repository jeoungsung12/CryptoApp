//
//  UpbitService.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation
import RxSwift
import RxCocoa

final class UpbitService {
    private let repository: UpbitRepositoryType = UpbitRepository()
    private var disposeBag = DisposeBag()
    
    func getAllCoin() -> Observable<[ExchangeEntity]> {
        return Observable.create { [weak self] observer in
            
            self?.repository.getAllCoin()
                .subscribe { data in
                    observer.onNext(data.map { $0.toEntity() })
                    observer.onCompleted()
                } onError: { error in
                    observer.onError(error)
                }
                .disposed(by: self?.disposeBag ?? DisposeBag())
            
            return Disposables.create()
        }
    }
}
