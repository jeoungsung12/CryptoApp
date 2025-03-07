//
//  CoinDetailViewController.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import UIKit
import Kingfisher
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

final class CoinDetailViewController: BaseViewController {
    private let starButton = UIBarButtonItem(image: .star, style: .plain, target: nil, action: nil)
    private let tableView = UITableView()
    private let navigationBar = DetailCustomNavigation()
    private let viewModel: CoinDetailViewModel
    private var disposeBag = DisposeBag()
    
    init(viewModel: CoinDetailViewModel) {
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
        let input = CoinDetailViewModel.Input(
            reloadTrigger: PublishRelay(),
            starTrigger: PublishRelay()
        )
        let output = viewModel.transform(input)
        input.reloadTrigger.accept(())
        
        let dataSource = RxTableViewSectionedReloadDataSource<DetailSection> { dataSource, tableView, indexPath, item in
            switch item {
            case let .header(entity):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailHeaderCell.id, for: indexPath) as? DetailHeaderCell else { return UITableViewCell() }
                cell.configure(entity)
                cell.selectionStyle = .none
                return cell
                
            case let .middle(entity):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailMiddleCell.id, for: indexPath) as? DetailMiddleCell else { return UITableViewCell() }
                cell.configure(entity)
                cell.selectionStyle = .none
                return cell
                
            case let .footer(entity):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailFooterCell.id, for: indexPath) as? DetailFooterCell else { return UITableViewCell() }
                cell.configure(entity)
                cell.selectionStyle = .none
                return cell
            }
        }
        
        output.detailResult
            .map { entity -> [DetailSection] in
                guard let entity = entity else { return [] }
                return [DetailSection(items: [
                    .header(entity.toHeaderEntity()),
                    .middle(entity.toMiddleEntity()),
                    .footer(entity.toFooterEntity())
                    ])]
            }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        output.detailResult
            .drive(with: self) { owner, entity in
                guard let entity = entity else { return }
                owner.navigationBar.configure(entity.name, entity.image)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        self.navigationItem.titleView = navigationBar
        self.navigationItem.rightBarButtonItem = starButton
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(DetailHeaderCell.self, forCellReuseIdentifier: DetailHeaderCell.id)
        tableView.register(DetailMiddleCell.self, forCellReuseIdentifier: DetailMiddleCell.id)
        tableView.register(DetailFooterCell.self, forCellReuseIdentifier: DetailFooterCell.id)
    }
    
    override func configureHierarchy() {
        self.view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    deinit {
        print(#function, self)
    }
}
