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
    private let arrowImageView = UIImageView()
    private let percentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        rankLabel.font = .largeRegular
        rankLabel.textColor = .customDarkGray
        
        thumbImageView.contentMode = .scaleAspectFill
        thumbImageView.clipsToBounds = true
        thumbImageView.backgroundColor = .customGray
        thumbImageView.layer.cornerRadius = 15
        
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.textColor = .customDarkGray
        
        subTitleLabel.font = .smallRegular
        subTitleLabel.textColor = .customGray
        
        arrowImageView.contentMode = .scaleAspectFit
    }
    
    override func configureHierarchy() {
        [rankLabel, thumbImageView, titleLabel, subTitleLabel, percentLabel, arrowImageView]
            .forEach { self.contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        rankLabel.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
        }
        
        thumbImageView.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(rankLabel.snp.trailing).offset(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(thumbImageView.snp.trailing).offset(8)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(thumbImageView.snp.trailing).offset(8)
        }
        
        //TODO: Layout
        percentLabel.snp.makeConstraints { make in
            
        }
        
        arrowImageView.snp.makeConstraints { make in
            
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
        
    }
    
}
