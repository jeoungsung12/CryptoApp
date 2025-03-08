//
//  ATPriceView.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/8/25.
//

import UIKit
import SnapKit

final class ATPriceView: BaseView {
    private let section = DetailSectionView()
    private let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        dateLabel.font = .smallRegular
        dateLabel.textColor = .customGray
        dateLabel.textAlignment = .left
    }
    
    override func configureHierarchy() {
        [section, dateLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        section.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(section.snp.bottom).offset(2)
        }
    }
    
    func configure(_ title: String,_ price: String,_ date: String) {
        section.configure(title, price)
        dateLabel.text = date
    }
}
