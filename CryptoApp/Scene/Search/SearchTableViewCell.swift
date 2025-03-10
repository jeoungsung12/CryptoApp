//
//  SearchTableViewCell.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import UIKit
import Kingfisher
import SnapKit
import RxSwift
import RxCocoa

final class SearchTableViewCell: BaseTableViewCell, ReusableIdentifier {
    private let thumbImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let rankLabel = UILabel()
    private let starbutton = UIButton()
    
    var viewModel = SearchTableViewModel()
    private lazy var input = SearchTableViewModel.Input(
        starStateTrigger: BehaviorRelay(value: ""),
        starTrigger: starbutton.rx.tap
    )
    private var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbImageView.image = nil
        [titleLabel, subTitleLabel, rankLabel].forEach {
            $0.text = nil
        }
    }
    
    override func setBinding() {
        let output = viewModel.transform(input)
        
        output.starBtnResult
            .drive(with: self) { owner, entity in
                owner.starbutton.setImage((entity.bool) ? .starFill : .star, for: .normal)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        thumbImageView.contentMode = .scaleToFill
        thumbImageView.clipsToBounds = true
        thumbImageView.backgroundColor = .customGray
        thumbImageView.layer.cornerRadius = 18
        
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.textColor = .customDarkGray
        
        subTitleLabel.font = .largeRegular
        subTitleLabel.textColor = .customGray
        
        rankLabel.font = .smallBold
        rankLabel.textColor = .customGray
        rankLabel.clipsToBounds = true
        rankLabel.layer.cornerRadius = 5
        rankLabel.textAlignment = .center
        rankLabel.backgroundColor = .customLightGray
        
        starbutton.tintColor = .customDarkGray
        starbutton.contentMode = .scaleAspectFit
    }
    
    override func configureHierarchy() {
        [thumbImageView, titleLabel, subTitleLabel, rankLabel, starbutton].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        thumbImageView.snp.makeConstraints { make in
            make.size.equalTo(36)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbImageView.snp.top)
            make.leading.equalTo(thumbImageView.snp.trailing).offset(12)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(thumbImageView.snp.bottom)
            make.leading.equalTo(thumbImageView.snp.trailing).offset(12)
            make.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(4)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.bottom.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(titleLabel.snp.trailing).offset(4)
        }
        
        starbutton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(24)
        }
    }
    
    func configure(_ model: SearchEntity) {
        titleLabel.text = model.symbol
        subTitleLabel.text = model.name
        rankLabel.text = " #\(model.rank) "
        input.starStateTrigger.accept(model.id)
        if let url = URL(string: model.thumb) {
            thumbImageView.kf.setImage(with: url)
        }
    }
    
    deinit {
        print(#function, self)
    }
    
}
