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
        [titleLabel, currentLabel, percentLabel, previousLabel, amountLabel]
            .forEach {
                self.contentView.addSubview($0)
            }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            
        }
        
        currentLabel.snp.makeConstraints { make in
            
        }
        
        percentLabel.snp.makeConstraints { make in
            
        }
        
        previousLabel.snp.makeConstraints { make in
            
        }
        
        amountLabel.snp.makeConstraints { make in
            
        }
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
    }
    
}
