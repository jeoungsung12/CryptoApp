//
//  ExchangeViewModel.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation
import RxSwift
import RxCocoa

final class ExchangeViewModel: BaseViewModel {
    private var disposeBag = DisposeBag()
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init() {
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
    
}

extension ExchangeViewModel {
    
    func transform(_ input: Input) -> Output {
        
        return Output()
    }
    
}
