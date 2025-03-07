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

final class ExchangeViewController: BaseViewController {
    private let headerView = ExchangeTableHeaderView()
    private let tableView = UITableView()
    
    private let viewModel = ExchangeViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setBinding() {
        let input = ExchangeViewModel.Input(
            reloadTrigger: PublishRelay()
        )
        let output = viewModel.transform(input)
        //TODO: ViewWillAppear
        input.reloadTrigger.accept(())
        
        output.coinResult
            .drive(tableView.rx.items(cellIdentifier: ExchangeTableViewCell.id, cellType: ExchangeTableViewCell.self)) { row, element, cell in
                cell.configure(element)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        self.setNavigation(title: "거래소")
        headerView.backgroundColor = .customLightGray
        configureTableView()
    }
    
    override func configureHierarchy() {
        [headerView, tableView].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func configureLayout() {
        headerView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
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
        tableView.rowHeight = 40
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ExchangeTableViewCell.self, forCellReuseIdentifier: ExchangeTableViewCell.id)
    }
    
}
