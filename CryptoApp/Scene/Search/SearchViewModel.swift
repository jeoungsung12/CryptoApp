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
        let searchTrigger: PublishRelay<String>
    }
    
    struct Output {
        let searchResult: Driver<[SearchEntity]>
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
        
        input.searchTrigger
            .withUnretained(self)
            .flatMapLatest { owner, text in
                owner.coinName = text
                return owner.service.getSearch(text: text)
                    .catch { error in
                        return Observable.just([])
                    }
            }
            .bind(with: self) { owner, entity in
                searchResult.accept(entity)
            }
            .disposed(by: disposeBag)
        
        return Output(
            searchResult: searchResult.asDriver(onErrorJustReturn: [])
        )
    }
    
    func isValidSearchText(_ text: String?) -> String? {
        guard var text = text else { return nil }
        text.removeAll { $0 == " " }
        return (text.count >= 1) ? text : nil
    }
    
}
