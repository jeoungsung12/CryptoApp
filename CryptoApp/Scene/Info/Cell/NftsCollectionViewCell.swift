//
//  NftsCollectionViewCell.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import Kingfisher
import SnapKit
import RxSwift
import RxCocoa

final class NftsCollectionViewCell: BaseCollectionViewCell, ReusableIdentifier {
    private let thumbImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let percentSection = PercentSection()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        thumbImageView.contentMode = .scaleToFill
        thumbImageView.clipsToBounds = true
        thumbImageView.backgroundColor = .customGray
        thumbImageView.layer.cornerRadius = 20
        
        titleLabel.font = .smallBold
        titleLabel.textAlignment = .center
        titleLabel.textColor = .customDarkGray
        
        subTitleLabel.font = .smallRegular
        subTitleLabel.textAlignment = .center
        subTitleLabel.textColor = .customGray
    }
    
    override func configureHierarchy() {
        [thumbImageView, titleLabel, subTitleLabel, percentSection]
            .forEach { self.contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        thumbImageView.snp.makeConstraints { make in
            make.size.equalTo(72)
            make.horizontalEdges.equalToSuperview()
            make.top.horizontalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
        }
        
        percentSection.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(subTitleLabel.snp.bottom).offset(4)
            make.bottom.lessThanOrEqualToSuperview().inset(4)
        }
    }
    
    func configure(_ model: PopularNftsEntity) {
        titleLabel.text = model.name
        subTitleLabel.text = model.volumePrice
        
        if let url = URL(string: model.image) {
            thumbImageView.kf.setImage(with: url)
        }
        percentSection.configure(model.volumePercent, color: model.color)
    }
    
    deinit {
        print(#function, self)
    }
}
