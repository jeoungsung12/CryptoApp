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
            make.height.equalTo(40)
            make.top.horizontalEdges.equalToSuperview().inset(24)
        }
        
        percentSection.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(priceLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        chartView.view.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.top.equalTo(percentSection.snp.bottom).offset(36)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        updateLabel.snp.makeConstraints { make in
            make.top.equalTo(chartView.view.snp.bottom).offset(8)
            make.bottom.horizontalEdges.equalToSuperview().inset(24)
        }
    }
    
    func configure(_ model: DetailHeaderEntity) {
        priceLabel.text = "₩" + model.price
        updateLabel.text = model.lastUpdated
        
        chartView = CoinChartHostingView(rootView: CoinChartView(chartData: model.chartData))
        chartView.view.removeFromSuperview()
        self.contentView.addSubview(chartView.view)
        configureLayout()
        
        percentSection.configure(model.percent, color: model.color)
    }
    
}
