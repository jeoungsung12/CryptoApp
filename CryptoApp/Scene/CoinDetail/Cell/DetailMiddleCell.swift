//
//  DetailMiddleCell.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import UIKit
import SnapKit

final class DetailMiddleCell: BaseTableViewCell, ReusableIdentifier {
    private let titleLabel = UILabel()
    private let moreBtn = MoreButton()
    private let containerView = UIView()
    private let priceContainerView = UIStackView()
    private let historyContainerView = UIStackView()
    private let high24Section = DetailSectionView()
    private let low24Section = DetailSectionView()
    
    //TODO: Date 설정
    private let highSection = DetailSectionView()
    private let highDateLabel = UILabel()
    private let lowSection = DetailSectionView()
    private let lowDateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureView() {
        titleLabel.text = "종목정보"
        titleLabel.textColor = .customDarkGray
        titleLabel.textAlignment = .left
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        containerView.backgroundColor = .customLightGray
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 15
        
        [priceContainerView, historyContainerView].forEach {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.distribution = .fillEqually
            $0.alignment = .center
        }
        
        [highDateLabel, lowDateLabel].forEach {
            $0.font = .smallRegular
            $0.textColor = .customGray
            $0.textAlignment = .left
        }
        
    }
    
    override func configureHierarchy() {
        [high24Section, low24Section].forEach {
            self.priceContainerView.addArrangedSubview($0)
        }
        [highSection, lowSection].forEach {
            self.historyContainerView.addArrangedSubview($0)
        }
        [priceContainerView, historyContainerView].forEach {
            self.containerView.addSubview($0)
        }
        [titleLabel, moreBtn, containerView].forEach { self.contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(24)
        }
        
        moreBtn.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualToSuperview().offset(4)
            make.verticalEdges.trailing.equalToSuperview().inset(24)
        }
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.horizontalEdges.bottom.equalToSuperview().inset(24)
        }
        
        priceContainerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        historyContainerView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
    }
    
    func configure(_ model: DetailMiddleEntity) {
        high24Section.configure("24시간 고가", model.high24)
        highSection.configure("역대 최고가", model.allTimeHigh)
        low24Section.configure("24시간 저가", model.low24)
        lowSection.configure("역대 최저가", model.allTimeLow)
    }
    
}

