//
//  DetailPercentSection.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/8/25.
//

import UIKit
import SnapKit

final class DetailPercentSection: BaseView {
    private let arrowImageView = UIImageView()
    private let percentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        arrowImageView.contentMode = .scaleAspectFit
        percentLabel.font = .largeBold
    }
    
    override func configureHierarchy() {
        [arrowImageView, percentLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        arrowImageView.snp.makeConstraints { make in
            make.size.equalTo(15)
            make.verticalEdges.leading.equalToSuperview()
        }
        
        percentLabel.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview()
            make.leading.equalTo(arrowImageView.snp.trailing).offset(4)
        }
    }
    
    func configure(_ percent: String, color: UIColor) {
        percentLabel.text = percent
        percentLabel.textColor = color
        arrowImageView.tintColor = color
        arrowImageView.image = (color == .customRed) ? .arrowUp : .arrowDown
        if color == .customDarkGray {
            arrowImageView.isHidden = true
        }
    }
    
    deinit {
        print(#function, self)
    }
}
