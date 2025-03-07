//
//  UpDownButton.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import SnapKit

final class UpDownButton: BaseButton {
    enum ButtonType {
        case none
        case up
        case down
    }
    
    private let nameLabel = UILabel()
    private let stackView = UIStackView()
    private let arrowUp = UIImageView()
    private let arrowDown = UIImageView()
    var type: ButtonType = .none
    
    init(alignment: NSTextAlignment) {
        super.init(frame: .zero)
        nameLabel.textAlignment = alignment
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
        [nameLabel, stackView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(3)
        }
        
        stackView.snp.makeConstraints { make in
            make.width.equalTo(9)
            make.top.equalTo(nameLabel.snp.top)
            make.bottom.equalTo(nameLabel.snp.bottom)
            make.trailing.lessThanOrEqualToSuperview().inset(4)
            make.leading.equalTo(nameLabel.snp.trailing).offset(4)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            configureType()
        }
    }
    
}

extension UpDownButton {
    
    private func configureType() {
        switch type {
        case .none:
            self.type = .down
        case .up:
            self.type = .none
        case .down:
            self.type = .up
        }
        configureButton()
    }
    
    private func configureButton() {
        arrowUp.tintColor = (type == .up ? .customDarkGray : .customGray)
        arrowDown.tintColor = (type == .down ? .customDarkGray : .customGray)
    }
    
    func configure(_ title: String) {
        nameLabel.text = title
    }
    
}
