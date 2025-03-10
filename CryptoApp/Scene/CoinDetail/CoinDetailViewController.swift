//
//  CoinDetailViewController.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/7/25.
//

import UIKit
import Kingfisher
import SnapKit
import Toast
import NVActivityIndicatorView
import RxSwift
import RxCocoa
import RxDataSources

final class CoinDetailViewController: BaseViewController {
    private let loadingIndicator = NVActivityIndicatorView(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)), type: .ballPulseSync, color: .customDarkGray)
    private let starButton = UIBarButtonItem(image: .star, style: .plain, target: nil, action: nil)
    private let tableView = UITableView()
    private let navigationBar = DetailCustomNavigation()
    
    private let viewModel: CoinDetailViewModel
    private lazy var input = CoinDetailViewModel.Input(
        starTrigger: starButton.rx.tap,
        reloadTrigger: PublishRelay()
    )
    private var disposeBag = DisposeBag()
    
    weak var coordinator: DetailCoordinator?
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
        let output = viewModel.transform(input)
        input.reloadTrigger.accept(())
        loadingIndicator.startAnimating()
        
        output.errorResult
            .drive(with: self) { owner, error in
                let vm = ErrorViewModel(notiType: .detail)
                let vc = ErrorViewController(viewModel: vm)
                vm.delegate = owner
                vc.configure(error)
                vc.modalPresentationStyle = .overCurrentContext
                owner.present(vc, animated: true)
                owner.loadingIndicator.stopAnimating()
            }
            .disposed(by: disposeBag)
        
        output.starBtnResult
            .drive(with: self) { owner, entity in
                owner.starButton.image = (entity.bool) ? .starFill : .star
                if !entity.message.isEmpty {
                    owner.view.makeToast(entity.message, duration: 1, position: .center)
                }
            }
            .disposed(by: disposeBag)
        
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
        
        let detailResult = output.detailResult
        
        detailResult
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
        
        detailResult
            .drive(with: self) { owner, entity in
                guard let entity = entity else { return }
                owner.navigationBar.configure(entity.name, entity.image)
                owner.loadingIndicator.stopAnimating()
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
        [tableView, loadingIndicator].forEach { self.view.addSubview($0) }
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    deinit {
        print(#function, self)
    }
}

extension CoinDetailViewController: ErrorDelegate {
    
    func reloadNetwork(type: ErrorSenderType) {
        switch type {
        case .detail:
            input.reloadTrigger.accept(())
        default:
            break
        }
    }
    
}
