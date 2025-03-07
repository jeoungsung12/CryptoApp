//
//  DetailCustomNavigation.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import UIKit
import Kingfisher
import SnapKit

final class DetailCustomNavigation: BaseView {
    private let thumbImageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setBinding() {
        
    }
    
    override func configureView() {
        thumbImageView.contentMode = .scaleToFill
        thumbImageView.clipsToBounds = true
        thumbImageView.layer.cornerRadius = 13
        
        titleLabel.textColor = .customDarkGray
        titleLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    override func configureHierarchy() {
        [thumbImageView, titleLabel]
            .forEach {
                self.addSubview($0)
            }
    }
    
    override func configureLayout() {
        
        thumbImageView.snp.makeConstraints { make in
            make.size.equalTo(26)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview()
            make.leading.equalTo(thumbImageView.snp.trailing).offset(8)
        }
    }
    
    func configure(_ title: String,_ image: String) {
        titleLabel.text = title
        if let url = URL(string: image) {
            thumbImageView.kf.setImage(with: url)
        } else {
            //TODO: 예외처리
        }
    }
    
}
