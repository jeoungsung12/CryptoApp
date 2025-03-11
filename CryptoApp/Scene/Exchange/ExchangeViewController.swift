//
//  ExchangeViewController.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import RxSwift
import RxCocoa

final class ExchangeViewController: BaseViewController {
    private let loadingIndicator = NVActivityIndicatorView(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)), type: .ballPulseSync, color: .customDarkGray)
    private let headerView = ExchangeHeaderView()
    private let tableView = UITableView()
    private lazy var headerButtons = [headerView.currentButton, headerView.previousButton, headerView.amountButton]
    
    private let viewModel = ExchangeViewModel()
    private var disposeBag = DisposeBag()
    private let input = ExchangeViewModel.Input(
        typeTrigger: PublishRelay(),
        reloadTrigger: BehaviorRelay(value: ExchangeButtonEntity(type: .amount, state: .none))
    )
    private var timerDispose: Disposable?
    
    weak var coordinator: ExchangeCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timerDispose?.dispose()
    }
    
    override func setBinding() {
        let output = viewModel.transform(input)
        loadingIndicator.startAnimating()
        self.disableTouchScreen()
        headerButtons.forEach { button in
            button.rx.tap
                .asDriver()
                .drive(with: self) { owner, _ in
                    owner.toggleButton(button)
                    let type = button.type
                    
                    owner.input.reloadTrigger.accept(ExchangeButtonEntity(type: type.configureButtonType(button.tag), state: type))
                    
                    let states = owner.headerButtons.map { $0.type }
                    owner.input.typeTrigger.accept(states)
                }
                .disposed(by: disposeBag)
        }
        
        output.errorResult
            .drive(with: self) { owner, error in
                let vm = ErrorViewModel(notiType: .exchange)
                let vc = ErrorViewController(viewModel: vm, errorType: error)
                vc.modalPresentationStyle = .overCurrentContext
                vm.delegate = owner
                owner.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        let coinResult = output.coinResult
        
        coinResult
            .drive(tableView.rx.items(cellIdentifier: ExchangeTableViewCell.id, cellType: ExchangeTableViewCell.self)) { row, element, cell in
                cell.configure(element)
            }
            .disposed(by: disposeBag)
        
        coinResult
            .drive(with: self) { owner, entity in
                owner.loadingIndicator.stopAnimating()
                owner.ableTouchScreen()
            }
            .disposed(by: disposeBag)
    }
    
    private func setTimer() {
        timerDispose = Observable<Int>.interval(.seconds(5), scheduler: MainScheduler.instance)
            .withLatestFrom(input.reloadTrigger)
            .bind(with: self) { owner, entity in
                let states = owner.headerButtons.map { $0.type }
                owner.viewModel.timerExchange(states, entity, owner.input)
            }
    }
    
    override func configureView() {
        self.setNavigation(title: "거래소")
        headerView.backgroundColor = .customLightGray
        configureTableView()
    }
    
    override func configureHierarchy() {
        [headerView, tableView, loadingIndicator].forEach {
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
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    deinit {
        print(#function, self)
    }
    
}

extension ExchangeViewController: ErrorDelegate {
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.rowHeight = 40
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ExchangeTableViewCell.self, forCellReuseIdentifier: ExchangeTableViewCell.id)
    }
    
    private func toggleButton(_ button: UIButton) {
        headerButtons.forEach {
                if !$0.isEqual(button) {
                    $0.type = .none
                }
            }
        button.isSelected.toggle()
    }
    
    func reloadNetwork(type: ErrorSenderType) {
        switch type {
        case .exchange:
            input.reloadTrigger.accept(ExchangeButtonEntity(type: .amount, state: .none))
        default:
            break
        }
    }
    
}
