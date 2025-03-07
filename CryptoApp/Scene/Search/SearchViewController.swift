//
//  SearchViewController.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    private let categoryView = SearchCategoryView()
    private let tableView = UITableView()
    
    private let viewModel = SearchViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setBinding() {
        
    }
    
    override func configureView() {
        categoryView.backgroundColor = .white
        configureTableView()
    }
    
    override func configureHierarchy() {
        [categoryView, tableView].forEach { self.view.addSubview($0) }
    }
    
    override func configureLayout() {
        categoryView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    deinit {
        print(#function)
    }
    
}

extension SearchViewController {
    
    private func configureTableView() {
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
//        tableView.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)
    }
    
    
    
}
