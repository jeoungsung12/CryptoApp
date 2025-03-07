//
//  CoinDetailViewModel.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources


struct DetailSection {
    var items: [DetailCellType]
}

enum DetailCellType {
    case header(DetailHeaderEntity)
    case middle(DetailMiddleEntity)
    case footer(DetailFooterEntity)
}

extension DetailSection: SectionModelType {
    typealias item = DetailCellType
    
    init(original: DetailSection, items: [DetailCellType]) {
        self = original
        self.items = items
    }
}


final class CoinDetailViewModel: BaseViewModel {
    private let service = GeckoService()
    private var disposeBag = DisposeBag()
    
    var coinId: String
    struct Input {
        let reloadTrigger: PublishRelay<Void>
        let starTrigger: PublishRelay<Void>
    }
    
    struct Output {
        let detailResult: Driver<GeckoDetailEntity?>
    }
    
    init(coinId: String) {
        self.coinId = coinId
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
    
}

extension CoinDetailViewModel {
    
    func transform(_ input: Input) -> Output {
        let detailResult: BehaviorRelay<GeckoDetailEntity?> = BehaviorRelay(value: nil)
        
        input.reloadTrigger
            .withUnretained(self)
            .flatMapLatest { _ in
                return self.service.getCoinDetail(id: self.coinId)
                    .catch { error in
                        return Observable.empty()
                    }
            }
            .bind(with: self) { owner, entity in
                detailResult.accept(entity)
            }
            .disposed(by: disposeBag)
        
        return Output(
            detailResult: detailResult.asDriver()
        )
    }
    
}
