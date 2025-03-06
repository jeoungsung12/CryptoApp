//
//  ExchangeViewController.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ExchangeViewController: BaseViewController {
    private let tableView = UITableView()
    private let headerView = ExchangeTableHeaderView()
    
    private let viewModel = ExchangeViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setBinding() {
        let input = ExchangeViewModel.Input()
        let output = viewModel.transform(input)
        
        
        tableView.rx.tableHeaderView
            .onNext(headerView)
    }
    
    override func configureView() {
        self.setNavigation(title: "거래소")
        configureTableView()
    }
    
    override func configureHierarchy() {
        self.view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    deinit {
        print(#function, self)
    }

}

extension ExchangeViewController {
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ExchangeTableViewCell.self, forHeaderFooterViewReuseIdentifier: ExchangeTableViewCell.id)
    }
    
}
