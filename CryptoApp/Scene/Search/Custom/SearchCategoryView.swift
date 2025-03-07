//
//  SearchCategoryView.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchCategoryView: BaseView {
    private let stackView = UIStackView()
    private let coinCategory = SearchCategoryItem()
    private let nftCategory = SearchCategoryItem()
    private let exchangeCategory = SearchCategoryItem()
    
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setBinding() {
        coinCategory.rx.tap
            .asDriver()
            .drive(with: self) { owner, _ in
                owner.coinCategory.isSelected = true
                owner.nftCategory.isSelected = false
                owner.exchangeCategory.isSelected = false
            }
            .disposed(by: disposeBag)
        
        nftCategory.rx.tap
            .asDriver()
            .drive(with: self) { owner, _ in
                owner.coinCategory.isSelected = false
                owner.nftCategory.isSelected = true
                owner.exchangeCategory.isSelected = false
            }
            .disposed(by: disposeBag)
        
        exchangeCategory.rx.tap
            .asDriver()
            .drive(with: self) { owner, _ in
                owner.coinCategory.isSelected = false
                owner.nftCategory.isSelected = false
                owner.exchangeCategory.isSelected = true
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
        
        coinCategory.isSelected = true
        nftCategory.isSelected = false
        exchangeCategory.isSelected = false
        
        coinCategory.configure("코인")
        nftCategory.configure("NFT")
        exchangeCategory.configure("거래소")
    }
    
    override func configureHierarchy() {
        [coinCategory, nftCategory, exchangeCategory].forEach { self.stackView.addArrangedSubview($0) }
        self.addSubview(stackView)
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
