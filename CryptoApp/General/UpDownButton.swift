//
//  UpDownButton.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import SnapKit

final class UpDownButton: BaseButton {
    private let nameLabel = UILabel()
    private let arrowUp = UIImageView()
    private let arrowDown = UIImageView()
    //TODO: 버튼의 상태 저장
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        nameLabel.textAlignment = .left
        nameLabel.textColor = .customDarkGray
        nameLabel.font = .largeBold
        
        [arrowUp, arrowDown].forEach {
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .customGray
        }
        
        arrowUp.image = .arrowUp
        arrowDown.image = .arrowDown
    }
    
    override func configureHierarchy() {
        
        [nameLabel, arrowUp, arrowDown].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        nameLabel.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
        }
        
        arrowUp.snp.makeConstraints { make in
            make.size.equalTo(9)
            make.top.equalTo(nameLabel.snp.top)
            make.trailing.lessThanOrEqualToSuperview().inset(4)
            make.leading.equalTo(nameLabel.snp.trailing).offset(4)
        }
        
        arrowDown.snp.makeConstraints { make in
            make.size.equalTo(9)
            make.bottom.equalTo(nameLabel.snp.bottom)
            make.trailing.lessThanOrEqualToSuperview().inset(4)
            make.leading.equalTo(nameLabel.snp.trailing).offset(4)
        }
    }
    
    func configure(_ title: String) {
        nameLabel.text = title
    }
    
}
