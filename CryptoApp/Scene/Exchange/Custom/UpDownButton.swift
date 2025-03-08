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
    var type: ExchangeButtonEntity.ExchangeButtonState = .none {
        didSet {
            configureButton()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        nameLabel.textColor = .customDarkGray
        nameLabel.font = .largeBold
        
        stackView.axis = .vertical
        stackView.spacing = -3
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        
        [arrowUp, arrowDown].forEach {
            $0.contentMode = .scaleToFill
            $0.tintColor = .customGray
        }
        
        arrowUp.image = .arrowUp
        arrowDown.image = .arrowDown
    }
    
    override func configureHierarchy() {
        [arrowUp, arrowDown].forEach {
            self.stackView.addArrangedSubview($0)
        }
        [stackView, nameLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.width.equalTo(9)
            make.trailing.equalToSuperview()
            make.top.equalTo(nameLabel.snp.top)
            make.bottom.equalTo(nameLabel.snp.bottom)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(3)
            make.trailing.equalToSuperview().inset(12)
            make.leading.greaterThanOrEqualToSuperview().offset(4)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            self.type = type.configureType()
        }
    }
    
}

extension UpDownButton {
    
    private func configureButton() {
        arrowUp.tintColor = (type == .up ? .customDarkGray : .customGray)
        arrowDown.tintColor = (type == .down ? .customDarkGray : .customGray)
    }
    
    func configure(_ title: String) {
        nameLabel.text = title
    }
    
}
