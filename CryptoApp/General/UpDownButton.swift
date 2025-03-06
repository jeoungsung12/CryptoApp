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
    private let stackView = UIStackView()
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
        
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    override func configureHierarchy() {
        [arrowUp, arrowDown].forEach {
            stackView.addArrangedSubview($0)
        }
        
        [nameLabel, stackView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        nameLabel.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.trailing.verticalEdges.equalToSuperview()
            make.leading.equalTo(nameLabel.snp.trailing).offset(4)
        }
        
        arrowUp.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        
        arrowDown.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
    }
    
    func configure(_ title: String) {
        nameLabel.text = title
    }
    
}
