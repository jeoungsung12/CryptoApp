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
    private let realmRepository: RealmRepositoryType = RealmRepository()
    private let service = GeckoService()
    private var disposeBag = DisposeBag()
    
    var coinId: String
    struct Input {
        let starTrigger: ControlEvent<Void>
        let reloadTrigger: PublishRelay<Void>
    }
    
    struct Output {
        let starBtnResult: Driver<RealmEntity>
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
        let starBtnResult: BehaviorRelay<RealmEntity> = BehaviorRelay(value: RealmEntity(bool: realmRepository.getState(coinId), message: ""))
        
        input.starTrigger
            .withLatestFrom(starBtnResult)
            .map { $0.bool }
            .bind(with: self) { owner, bool in
                let result = (bool) ? owner.realmRepository.deleteItem(owner.coinId) : owner.realmRepository.addItem(owner.coinId)
                switch result {
                case .add:
                    starBtnResult.accept(RealmEntity(bool: true, message: result.description))
                case .delete:
                    starBtnResult.accept(RealmEntity(bool: false, message: result.description))
                case .error:
                    starBtnResult.accept(RealmEntity(bool: bool, message: result.description))
                }
            }
            .disposed(by: disposeBag)
        
        input.reloadTrigger
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                return owner.service.getCoinDetail(id: owner.coinId)
                    .catch { error in
                        return Observable.empty()
                    }
            }
            .bind { entity in
                detailResult.accept(entity)
            }
            .disposed(by: disposeBag)
        
        return Output(
            starBtnResult: starBtnResult.asDriver(),
            detailResult: detailResult.asDriver()
        )
    }
    
}
