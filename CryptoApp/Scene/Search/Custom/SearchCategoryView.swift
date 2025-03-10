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
    let coinCategory = SearchCategoryItem()
    let nftCategory = SearchCategoryItem()
    let exchangeCategory = SearchCategoryItem()
    
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
        
        coinCategory.isSelected = true
        nftCategory.isSelected = false
        exchangeCategory.isSelected = false
        
        coinCategory.tag = 0
        nftCategory.tag = 1
        exchangeCategory.tag = 2
        
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
    
    deinit {
        print(#function, self)
    }
    
}
