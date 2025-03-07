//
//  PercentSection.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import UIKit
import SnapKit

final class PercentSection: BaseView {
    private let arrowImageView = UIImageView()
    private let percentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        arrowImageView.contentMode = .scaleAspectFit
        percentLabel.font = .smallBold
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
    
    func configure(_ percent: Double) {
        //TODO: 퍼센트 구현
    }
    
    deinit {
        print(#function, self)
    }
}
