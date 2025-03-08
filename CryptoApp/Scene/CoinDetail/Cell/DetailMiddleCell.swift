//
//  DetailMiddleCell.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import UIKit
import SnapKit
import Toast
import RxSwift
import RxCocoa

final class DetailMiddleCell: BaseTableViewCell, ReusableIdentifier {
    private let titleLabel = UILabel()
    private let moreBtn = MoreButton()
    private let containerView = UIView()
    private let priceContainerView = UIStackView()
    private let historyContainerView = UIStackView()
    private let high24Section = DetailSectionView()
    private let low24Section = DetailSectionView()
    private let athSection = ATPriceView()
    private let atlSection = ATPriceView()
    
    private let disposeBag = DisposeBag()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setBinding() {
        moreBtn.rx.tap.asDriver()
            .drive(with: self) { owner, _ in
                self.contentView.makeToast("준비 중입니다.", duration: 1.0, position: .bottom)
            }
            .disposed(by: disposeBag)
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
            $0.alignment = .fill
        }
        
    }
    
    override func configureHierarchy() {
        [high24Section, low24Section].forEach {
            self.priceContainerView.addArrangedSubview($0)
        }
        [athSection, atlSection].forEach {
            self.historyContainerView.addArrangedSubview($0)
        }
        [priceContainerView, historyContainerView].forEach {
            self.containerView.addSubview($0)
        }
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
            make.height.equalTo(150)
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.horizontalEdges.bottom.equalToSuperview().inset(24)
        }
        
        priceContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalToSuperview().offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        historyContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(12)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.greaterThanOrEqualTo(priceContainerView.snp.bottom).offset(12)
        }
    }
    
    func configure(_ model: DetailMiddleEntity) {
        high24Section.configure("24시간 고가", model.high24)
        low24Section.configure("24시간 저가", model.low24)
        
        athSection.configure("역대 최고가", model.allTimeHigh, model.highDate)
        atlSection.configure("역대 최저가", model.allTimeLow, model.lowDate)
    }
    
}

