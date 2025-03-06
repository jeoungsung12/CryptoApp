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
    }
    
    override func configureHierarchy() {
        [coinCategory, nftCategory, exchangeCategory].forEach { self.stackView.addArrangedSubview($0) }
        self.addSubview(stackView)
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
//        
//        coinCategory.snp.makeConstraints { make in
//            
//        }
//        
//        nftCategory.snp.makeConstraints { make in
//            
//        }
//        
//        exchangeCategory.snp.makeConstraints { make in
//            
//        }
    }
    
}
