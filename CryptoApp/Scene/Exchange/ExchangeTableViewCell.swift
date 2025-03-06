//
//  ExchangeTableViewCell.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import SwiftUI
import SnapKit

final class ExchangeTableViewCell: BaseTableViewCell, ReusableIdentifier {
    private let titleLabel = UILabel()
    private let currentLabel = UILabel()
    private let percentLabel = UILabel()
    private let previousLabel = UILabel()
    private let amountLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureView() {
        titleLabel.font = .largeBold
        titleLabel.textAlignment = .left
        
        previousLabel.font = .smallRegular
        
        [currentLabel, percentLabel, amountLabel]
            .forEach {
                $0.font = .largeRegular
                $0.textAlignment = .right
            }
        
        [titleLabel, currentLabel, amountLabel]
            .forEach {
                $0.textColor = .customDarkGray
            }
    }
    
    override func configureHierarchy() {
        [titleLabel, amountLabel, previousLabel, percentLabel, currentLabel]
            .forEach {
                self.contentView.addSubview($0)
            }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.leading.equalToSuperview().inset(12)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.trailing.verticalEdges.equalToSuperview().inset(12)
        }
        
//        percentLabel.snp.makeConstraints { make in
//            make.height.equalTo(20)
//            make.trailing.equalTo(amountLabel.snp.leading).inset(24)
//        }
//        
//        previousLabel.snp.makeConstraints { make in
//            make.height.equalTo(10)
//            make.top.equalTo(percentLabel.snp.bottom).offset(4)
//            make.trailing.equalTo(amountLabel.snp.leading).inset(24)
//        }
//        
//        currentLabel.snp.makeConstraints { make in
//            make.height.equalTo(20)
//            make.trailing.equalTo(percentLabel.snp.leading).inset(12)
//            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(12)
//        }
    }
    
    deinit {
        print(#function, self)
    }
    
}

extension ExchangeTableViewCell {
    
    func configure(_ model: ExchangeEntity) {
        titleLabel.text = model.marketName
        //TODO: 소숫점 계산
        currentLabel.text = model.currentPrice.formatted()
        percentLabel.text = model.changePercent.formatted()
        previousLabel.text = model.changePrice.formatted()
        amountLabel.text = model.tradeVolume.formatted()
        
        //TODO: 색 계산
        
    }
    
}
