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
    private let arrowImageView = UIImageView()
    private let percentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        thumbImageView.contentMode = .scaleAspectFill
        thumbImageView.clipsToBounds = true
        thumbImageView.backgroundColor = .customGray
        thumbImageView.layer.cornerRadius = 20
        
        titleLabel.font = .largeBold
        titleLabel.textAlignment = .center
        titleLabel.textColor = .customDarkGray
        
        subTitleLabel.font = .smallRegular
        subTitleLabel.textAlignment = .center
        subTitleLabel.textColor = .customGray
        
        arrowImageView.contentMode = .scaleAspectFit
    }
    
    override func configureHierarchy() {
        [thumbImageView, titleLabel, subTitleLabel, arrowImageView, percentLabel]
            .forEach { self.contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        thumbImageView.snp.makeConstraints { make in
            make.size.equalTo(70)
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
        
        arrowImageView.snp.makeConstraints { make in
            
        }
        
        percentLabel.snp.makeConstraints { make in
            
        }
        
    }
    
    func configure(_ model: PopularNftsEntity) {
        titleLabel.text = model.name
        subTitleLabel.text = model.volumePrice
        
        if let url = URL(string: model.image) {
            thumbImageView.kf.setImage(with: url)
        } else {
            //TODO: 예외처리
        }
        
        //TODO: Percent
    }
    
}
