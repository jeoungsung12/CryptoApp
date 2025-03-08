//
//  ExchangeTableHeaderView.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ExchangeHeaderView: BaseView {
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    let currentButton = UpDownButton()
    let previousButton = UpDownButton()
    let amountButton = UpDownButton()
    
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        self.backgroundColor = .customGray
        
        titleLabel.text = "코인"
        titleLabel.font = .largeBold
        titleLabel.textColor = .customDarkGray
        titleLabel.textAlignment = .left
        
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        currentButton.tag = 0
        previousButton.tag = 1
        amountButton.tag = 2
        
        currentButton.configure("현재가")
        previousButton.configure("전일대비")
        amountButton.configure("거래대금")
    }
    
    override func configureHierarchy() {
        [titleLabel, currentButton, previousButton, amountButton].forEach {
            self.stackView.addArrangedSubview($0)
        }
        self.addSubview(stackView)
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.height.equalTo(26)
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(24)
        }
    }
    
    deinit {
        print(#function, self)
    }
    
}
