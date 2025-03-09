//
//  SearchViewModel.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel: BaseViewModel {
    private let service = GeckoService()
    private var disposeBag = DisposeBag()
    
    var coinName: String
    struct Input {
        let searchTrigger: BehaviorRelay<String>
    }
    
    struct Output {
        let errorResult: Driver<CoingeckoError>
        let searchResult: BehaviorRelay<[SearchEntity]>
    }
    
    init(coinName: String) {
        self.coinName = coinName
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
}

extension SearchViewModel {
    
    func transform(_ input: Input) -> Output {
        let searchResult: BehaviorRelay<[SearchEntity]> = BehaviorRelay(value: [])
        let errorResult: PublishRelay<CoingeckoError> = PublishRelay()
        
        input.searchTrigger
            .withUnretained(self)
            .flatMapLatest { owner, text in
                owner.coinName = text
                return owner.service.getSearch(text: text)
                    .catch { error in
                        if let geckoError = error as? CoingeckoError {
                            errorResult.accept(geckoError)
                        } else {
                            errorResult.accept(.decoding)
                        }
                        return Observable.just([])
                    }
            }
            .bind(to: searchResult)
            .disposed(by: disposeBag)
        
        return Output(
            errorResult: errorResult.asDriver(onErrorJustReturn: CoingeckoError.decoding),
            searchResult: searchResult
        )
    }
    
    func isValidSearchText(_ text: String?) -> String? {
        guard var text = text else { return nil }
        text.removeAll { $0 == " " }
        return (text.count >= 1) ? text : nil
    }
    
}
