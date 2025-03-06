//
//  CoinCollectionViewCell.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CoinCollectionViewCell: BaseCollectionViewCell, ReusableIdentifier {
    private let rankLabel = UILabel()
    private let thumbImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let percentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        
    }
    
    override func configureHierarchy() {
        
    }
    
    override func configureLayout() {
        
    }
    
}
