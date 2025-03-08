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
    
    func getAllCoin() -> Observable<[UpbitResponseDTO]> {
        return repository.getAllCoin()
    }
}
