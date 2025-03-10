//
//  PercentPriceView.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import UIKit
import SnapKit

final class PercentPriceView: BaseView {
    private let percentLabel = UILabel()
    private let previousLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        percentLabel.font = .largeRegular
        previousLabel.font = .smallRegular
        [percentLabel, previousLabel].forEach { $0.textAlignment = .right}
    }
    
    override func configureHierarchy() {
        [percentLabel, previousLabel].forEach { self.addSubview($0) }
    }
    
    override func configureLayout() {
        percentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.horizontalEdges.equalToSuperview()
        }
        previousLabel.snp.makeConstraints { make in
            make.top.equalTo(percentLabel.snp.bottom).offset(2)
            make.horizontalEdges.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().inset(4)
        }
    }
    
    func configure(_ model: ExchangeEntity) {
        previousLabel.text = model.changePrice
        percentLabel.text = model.changePercent
        
        [previousLabel, percentLabel].forEach {
            $0.textColor = model.color
        }
    }
    
    deinit {
        print(#function, self)
    }
}
