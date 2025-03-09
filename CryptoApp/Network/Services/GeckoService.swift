//
//  GeckoService.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation
import RxSwift
import RxCocoa

final class GeckoService {
    private let repository: GeckoRepositoryType = GeckoRepository()
    private var disposeBag = DisposeBag()
    
    func getCoinDetail(id: String) -> Observable<GeckoDetailEntity> {
        return Observable.create { [weak self] observer in
            self?.repository.getCoinDetail(id: id)
                .subscribe(onNext: { data in
                    guard let data = data.first else {
                        observer.onError(CoingeckoError.decoding)
                        return
                    }
                    observer.onNext(data.toEntity())
                    observer.onCompleted()
                }, onError: { error in
                    observer.onError(error)
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            return Disposables.create()
        }
    }
    
    func getTrending() -> Observable<PopularEntity> {
        return Observable.create { [weak self] observer in
            self?.repository.getTrending()
                .subscribe(onNext: { data in
                    observer.onNext(data.toCoinEntity())
                    observer.onCompleted()
                }, onError: { error in
                    observer.onError(error)
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            return Disposables.create()
        }
    }
    
    func getSearch(text: String) -> Observable<[SearchEntity]> {
        return Observable.create { [weak self] observer in
            self?.repository.getSearch(text: text)
                .subscribe(onNext: { data in
                    observer.onNext(data.toEntity())
                    observer.onCompleted()
                }, onError: { error in
                    observer.onError(error)
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            return Disposables.create()
        }
    }
    
    deinit {
        print(#function, self)
    }
}
