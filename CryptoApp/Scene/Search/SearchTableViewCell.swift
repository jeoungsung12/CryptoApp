//
//  SearchTableViewCell.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchTableViewCell: BaseTableViewCell, ReusableIdentifier {
    private let thumbImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let rankLabel = UILabel()
    private let starbutton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureView() {
        thumbImageView.contentMode = .scaleToFill
        thumbImageView.clipsToBounds = true
        thumbImageView.backgroundColor = .customGray
        thumbImageView.layer.cornerRadius = 15
        
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.textColor = .customDarkGray
        
        subTitleLabel.font = .smallRegular
        subTitleLabel.textColor = .customGray
        
        rankLabel.font = .smallBold
        rankLabel.textColor = .customGray
        rankLabel.layer.cornerRadius = 5
        rankLabel.backgroundColor = .customLightGray
        
        starbutton.tintColor = .customDarkGray
    }
    
    override func configureHierarchy() {
        [thumbImageView, titleLabel, subTitleLabel, rankLabel, starbutton].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        thumbImageView.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.leading.equalToSuperview().inset(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbImageView.snp.bottom)
            make.leading.equalTo(thumbImageView.snp.trailing).offset(12)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(thumbImageView.snp.bottom)
            make.leading.equalTo(thumbImageView.snp.trailing).offset(12)
            make.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(4)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.top.equalTo(titleLabel.snp.top)
            make.bottom.equalTo(titleLabel.snp.bottom)
        }
    }
    
    func configure() {
        
    }
    
}
