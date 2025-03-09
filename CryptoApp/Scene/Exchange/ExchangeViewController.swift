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
        
        output.coinResult
            .drive(tableView.rx.items(cellIdentifier: ExchangeTableViewCell.id, cellType: ExchangeTableViewCell.self)) { row, element, cell in
                cell.configure(element)
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
    
    private func toggleButton(_ button: UIButton) {
        headerButtons.forEach {
                if !$0.isEqual(button) {
                    $0.type = .none
                }
            }
        button.isSelected.toggle()
    }
    
}
