//
//  SearchCategoryItem.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchCategoryItem: BaseButton {
    private let btnLabel = UILabel()
    private let lineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        btnLabel.textAlignment = .center
        btnLabel.font = .systemFont(ofSize: 17, weight: .heavy)
        btnLabel.textColor = (isSelected) ? .customDarkGray : .customGray
        lineView.backgroundColor = (isSelected) ? .customDarkGray : .customGray
    }
    
    override func configureHierarchy() {
        [btnLabel, lineView].forEach { self.addSubview($0) }
    }
    
    override func configureLayout() {
        btnLabel.snp.makeConstraints { make in
            make.center.horizontalEdges.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.greaterThanOrEqualTo(btnLabel.snp.bottom).offset(12)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            buttonTapped()
        }
    }
    
    private func buttonTapped() {
        btnLabel.textColor = (isSelected) ? .customDarkGray : .customGray
        lineView.backgroundColor = (isSelected) ? .customDarkGray : .customGray
        
        lineView.snp.updateConstraints { make in
            make.height.equalTo(2)
        }
    }
    
    func configure(_ title: String) {
        btnLabel.text = title
    }
    
    deinit {
        print(#function, self)
    }
}
