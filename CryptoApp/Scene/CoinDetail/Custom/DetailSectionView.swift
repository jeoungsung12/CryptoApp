//
//  DetailSectionView.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import UIKit
import SnapKit

final class DetailSectionView: BaseView {
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        titleLabel.textColor = .customGray
        titleLabel.font = .largeRegular
        
        priceLabel.textColor = .customDarkGray
        priceLabel.font = .largeBold
        
        [titleLabel, priceLabel].forEach{
            $0.textAlignment = .left
        }
    }
    
    override func configureHierarchy() {
        [titleLabel, priceLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func configure(_ title: String,_ price: Double) {
        titleLabel.text = title
        //TODO: 소숫점 자리 계산
        priceLabel.text = price.formatted()
    }
    
}
