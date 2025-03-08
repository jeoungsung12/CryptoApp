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
    
    private let viewModel: SearchViewModel
    private var disposeBag = DisposeBag()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setBinding() {
        let input = SearchViewModel.Input(
            searchTrigger: PublishRelay()
        )
        let output = viewModel.transform(input)
        input.searchTrigger.accept(viewModel.coinName)
        
        output.searchResult
            .drive(tableView.rx.items(cellIdentifier: SearchTableViewCell.id, cellType: SearchTableViewCell.self)) { row, element, cell in
                cell.configure(element)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(SearchEntity.self)
            .observe(on: MainScheduler.instance)
            .bind(with: self) { owner, entity in
                let vm = CoinDetailViewModel(coinId: entity.id)
                let vc = CoinDetailViewController(viewModel: vm)
                //TODO: Coordinate
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
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
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.bottom)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    deinit {
        print(#function)
    }
    
}

extension SearchViewController {
    
    private func configureTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = 70
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
    }
    
}
