//
//  DetailHeaderCell.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import UIKit
import SnapKit

final class DetailHeaderCell: BaseTableViewCell, ReusableIdentifier {
    private let priceLabel = UILabel()
    private let arrowImageView = UIImageView()
    //TODO: GeneralView로 만들기
    private let percentLabel = UILabel()
    private let updateLabel = UILabel()
    //TODO: ChartView
    private let chartView = CoinChartHostingView(rootView: CoinChartView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureView() {
        priceLabel.textColor = .customDarkGray
        priceLabel.textAlignment = .left
        priceLabel.font = .boldSystemFont(ofSize: 30)
        
        arrowImageView.contentMode = .scaleAspectFit
        
        percentLabel.font = .largeBold
        percentLabel.textAlignment = .left
        
        updateLabel.textColor = .customGray
        updateLabel.font = .smallRegular
        updateLabel.textAlignment = .left
    }
    
    override func configureHierarchy() {
        [priceLabel, arrowImageView, percentLabel, updateLabel].forEach {
            self.contentView.addSubview($0)
        }
        //TODO: ChartView ADD
    }
    
    override func configureLayout() {
        priceLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(24)
        }
        
        
    }
    
    func configure(_ model: DetailHeaderEntity) {
        //TODO: 포맷 수정
        priceLabel.text = model.price.formatted()
        //TODO: arrow 이미지 및 퍼센트
        //TODO: Chart
        //TODO: update format
        updateLabel.text = model.lastUpdated
    }
    
}
