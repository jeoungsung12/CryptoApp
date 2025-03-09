//
//  CoinCollectionViewCell.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import Kingfisher
import SnapKit
import RxSwift
import RxCocoa

final class CoinCollectionViewCell: BaseCollectionViewCell, ReusableIdentifier {
    private let rankLabel = UILabel()
    private let thumbImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let percentSection = PercentSection()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        rankLabel.font = .largeRegular
        rankLabel.textColor = .customDarkGray
        
        thumbImageView.contentMode = .scaleToFill
        thumbImageView.clipsToBounds = true
        thumbImageView.backgroundColor = .customGray
        thumbImageView.layer.cornerRadius = (13)
        
        titleLabel.font = .largeBold
        titleLabel.textColor = .customDarkGray
        
        subTitleLabel.font = .smallRegular
        subTitleLabel.textColor = .customGray
    }
    
    override func configureHierarchy() {
        [rankLabel, thumbImageView, titleLabel, subTitleLabel, percentSection]
            .forEach { self.contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        rankLabel.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
        }
        
        thumbImageView.snp.makeConstraints { make in
            make.size.equalTo(26)
            make.centerY.equalToSuperview()
            make.leading.equalTo(rankLabel.snp.trailing).offset(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbImageView.snp.top)
            make.leading.equalTo(thumbImageView.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(percentSection.snp.leading).inset(4)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(thumbImageView.snp.bottom)
            make.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(thumbImageView.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(percentSection.snp.leading).inset(4)
        }
        
        percentSection.snp.makeConstraints { make in
            make.centerY.trailing.equalToSuperview()
            make.leading.greaterThanOrEqualTo(subTitleLabel.snp.leading).offset(4)
        }
        
        percentSection.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        [titleLabel, subTitleLabel].forEach {
            $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }
    }
    
    func configure(_ model: PopularCoinEntity,_ items: Int) {
        rankLabel.text = "\(items + 1)"
        titleLabel.text = model.symbol
        subTitleLabel.text = model.name
        
        if let url = URL(string: model.image) {
            //TODO: ImageDownSampling
            thumbImageView.kf.setImage(with: url)
        } else {
            //TODO: 예외처리
        }
        percentSection.configure(model.volumePercent, color: model.color)
    }
    
}
