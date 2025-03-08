//
//  DetailFooterCell.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import UIKit
import SnapKit

final class DetailFooterCell: BaseTableViewCell, ReusableIdentifier {
    private let titleLabel = UILabel()
    private let moreBtn = MoreButton()
    private let containerView = UIView()
    private let priceContainerView = UIStackView()
    private let marketPriceSection = DetailSectionView()
    private let fdvSection = DetailSectionView()
    private let amountSection = DetailSectionView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureView() {
        titleLabel.text = "투자지표"
        titleLabel.textColor = .customDarkGray
        titleLabel.textAlignment = .left
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        containerView.backgroundColor = .customLightGray
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 15
        
        priceContainerView.axis = .vertical
        priceContainerView.spacing = 12
        priceContainerView.distribution = .fillEqually
        priceContainerView.alignment = .leading
    }
    
    override func configureHierarchy() {
        [marketPriceSection, fdvSection, amountSection].forEach {
            self.priceContainerView.addArrangedSubview($0)
        }
        containerView.addSubview(priceContainerView)
        [titleLabel, moreBtn, containerView].forEach { self.contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
        }
        
        moreBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(24)
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(4)
        }
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.horizontalEdges.bottom.equalToSuperview().inset(24)
        }
        
        priceContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(24)
        }
    }
    
    func configure(_ model: DetailFooterEntity) {
        marketPriceSection.configure("시가총액", model.marketCap)
        fdvSection.configure("완전 희석 가치(FDV)", model.fdvValue)
        amountSection.configure("총 거래량", model.volume)
    }
    
}
