//
//  CustomSearchBar.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CustomSearchBar: BaseView {
    let searchButton = UIButton()
    let searchTextField = UITextField()
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.customGray.cgColor
    }
    
    override func configureView() {
        searchButton.tintColor = .customGray
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        
        searchTextField.placeholder = "검색어를 입력해주세요"
        searchTextField.textColor = .customDarkGray
        searchTextField.backgroundColor = .white
    }
    
    override func configureHierarchy() {
        [searchButton, searchTextField].forEach { self.addSubview($0) }
    }
    
    override func configureLayout() {
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.verticalEdges.leading.equalToSuperview().inset(12)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(searchButton.snp.trailing).offset(12)
            make.trailing.verticalEdges.equalToSuperview().inset(12)
        }
    }
    
}
