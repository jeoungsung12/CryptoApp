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
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let currentLabel = UILabel()
    private let amountLabel = UILabel()
    private let percentView = PercentPriceView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureView() {
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        titleLabel.font = .largeBold
        titleLabel.textAlignment = .left
        
        [currentLabel, amountLabel]
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
        [titleLabel, currentLabel, percentView, amountLabel]
            .forEach {
                self.stackView.addArrangedSubview($0)
            }
        self.contentView.addSubview(stackView)
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.verticalEdges.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(24)
        }
    }
    
    deinit {
        print(#function, self)
    }
    
}

extension ExchangeTableViewCell {
    
    func configure(_ model: ExchangeEntity) {
        titleLabel.text = model.marketName
        currentLabel.text = model.currentPrice
        amountLabel.text = model.tradeVolume
        
        percentView.configure(model)
    }
    
}
