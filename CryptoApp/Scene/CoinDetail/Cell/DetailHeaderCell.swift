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
    private let percentSection = DetailPercentSection()
    private let updateLabel = UILabel()
    
    private var chartView = CoinChartHostingView(rootView: CoinChartView(chartData: []))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureView() {
        priceLabel.textColor = .customDarkGray
        priceLabel.textAlignment = .left
        priceLabel.font = .boldSystemFont(ofSize: 30)
        
        updateLabel.textColor = .customGray
        updateLabel.font = .smallRegular
        updateLabel.textAlignment = .left
    }
    
    override func configureHierarchy() {
        [priceLabel, percentSection, chartView.view, updateLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-12)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        percentSection.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(24)
        }
        
        chartView.view.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(3)
            make.top.equalTo(priceLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        updateLabel.snp.makeConstraints { make in
            make.top.equalTo(chartView.view.snp.bottom).offset(8)
            make.bottom.horizontalEdges.equalToSuperview().inset(24)
        }
    }
    
    func configure(_ model: DetailHeaderEntity) {
        priceLabel.text = "₩" + model.price
        //TODO: arrow 이미지 및 퍼센트
        //TODO: update format
        updateLabel.text = model.lastUpdated
        
        //TODO: 이게 최선?
        chartView = CoinChartHostingView(rootView: CoinChartView(chartData: model.chartData))
        chartView.view.removeFromSuperview()
        self.contentView.addSubview(chartView.view)

        chartView.view.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(3)
            make.top.equalTo(priceLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        percentSection.configure(model.percent, color: model.color)
    }
    
}
