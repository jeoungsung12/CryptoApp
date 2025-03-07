//
//  moreButton.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import UIKit
import SnapKit

final class MoreButton: BaseButton {
    private let buttonLabel = UILabel()
    private let arrowImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        buttonLabel.textColor = .customGray
        buttonLabel.text = "더보기"
        buttonLabel.font = .systemFont(ofSize: 17, weight: .regular)
        buttonLabel.textAlignment = .right
        
        arrowImage.image = .arrowRight
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.tintColor = .customGray
    }
    
    override func configureHierarchy() {
        [buttonLabel, arrowImage].forEach { self.addSubview($0) }
    }
    
    override func configureLayout() {
        buttonLabel.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
        }
        
        arrowImage.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.verticalEdges.trailing.equalToSuperview()
            make.leading.equalTo(buttonLabel.snp.trailing).offset(8)
        }
    }
    
    deinit {
        print(#function, self)
    }
    
}
