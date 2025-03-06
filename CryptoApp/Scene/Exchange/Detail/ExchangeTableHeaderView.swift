//
//  ExchangeTableHeaderView.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import SnapKit

final class ExchangeTableHeaderView: BaseView {
    private let titleLabel = UILabel()
    private let currentButton = UpDownButton()
    private let previousButton = UpDownButton()
    private let amountButton = UpDownButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        self.backgroundColor = .customGray
        
        titleLabel.text = "코인"
        titleLabel.font = .largeBold
        titleLabel.textColor = .customDarkGray
        
        currentButton.configure("현재가")
        previousButton.configure("전일대비")
        amountButton.configure("거래대금")
    }
    
    override func configureHierarchy() {
        [titleLabel, amountButton, previousButton, currentButton]
            .forEach {
                self.addSubview($0)
            }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.leading.verticalEdges.equalToSuperview().inset(12)
        }
        
        amountButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.trailing.verticalEdges.equalToSuperview().inset(12)
        }
        
        previousButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.verticalEdges.equalToSuperview().inset(12)
            make.trailing.equalTo(amountButton.snp.leading).inset(24)
        }
        
        currentButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.verticalEdges.equalToSuperview().inset(12)
            make.trailing.equalTo(previousButton.snp.leading).inset(12)
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(12)
        }
    }
    
    deinit {
        print(#function, self)
    }
    
}
