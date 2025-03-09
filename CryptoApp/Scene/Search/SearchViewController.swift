//
//  SearchViewController.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import NVActivityIndicatorView
import SnapKit
import Toast
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    private let searchTextField = UITextField()
    private let categoryView = SearchCategoryView()
    private let tableView = UITableView()
    private lazy var categoryButtons = [categoryView.coinCategory, categoryView.nftCategory, categoryView.exchangeCategory]
    
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
            .drive(tableView.rx.items(cellIdentifier: SearchTableViewCell.id, cellType: SearchTableViewCell.self)) { [weak self] row, element, cell in
                guard let self = self else { return }
                cell.configure(element)
                cell.viewModel.delegate = self
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
        
        searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .withLatestFrom(searchTextField.rx.text.orEmpty)
            .withUnretained(self)
            .map { owner, text in
                owner.viewModel.isValidSearchText(text)
            }
            .bind(with: self) { owner, text in
                guard let text = text else {
                    owner.searchTextField.text = owner.viewModel.coinName
                    owner.view.makeToast("한 글자 이상의 검색어를 입력하세요!", duration: 1, position: .center)
                    return
                }
                if owner.viewModel.coinName.isEqual(text) {
                    owner.view.makeToast("기존 검색어와 동일합니다!", duration: 1, position: .center)
                } else {
                    input.searchTrigger.accept(text)
                }
            }
            .disposed(by: disposeBag)
        
        categoryButtons.forEach { button in
            button.rx.tap
                .asDriver()
                .drive(with: self) { owner, _ in
                    owner.toggleButton(button)
                }
                .disposed(by: disposeBag)
        }
    }
    
    override func configureView() {
        self.setNavigation()
        self.navigationItem.titleView = searchTextField
        searchTextField.text = viewModel.coinName
        searchTextField.textAlignment = .left
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
        
        searchTextField.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width - 50)
        }
    }
    
    deinit {
        print(#function, self)
    }
    
}

extension SearchViewController: ToastDelegate {
    
    private func configureTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = 70
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
    }
    
    private func toggleButton(_ button: UIButton) {
        categoryButtons.forEach {
            $0.isSelected = false
            if $0.isEqual(button) {
                $0.isSelected = true
                //TODO: 데이터 초기화
            }
        }
    }
    
    func toastMessage(_ message: String) {
        print(#function)
        self.view.makeToast(message, duration: 1, position: .center)
    }
    
}
