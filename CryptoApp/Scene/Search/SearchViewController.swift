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
    private let loadingIndicator = NVActivityIndicatorView(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)), type: .ballPulseSync, color: .customDarkGray)
    private let searchTextField = UITextField()
    private let categoryView = SearchCategoryView()
    private let tableView = UITableView()
    private lazy var categoryButtons = [categoryView.coinCategory, categoryView.nftCategory, categoryView.exchangeCategory]
    private let swipeLeft = UISwipeGestureRecognizer()
    private let swipeRight = UISwipeGestureRecognizer()
    
    private let viewModel: SearchViewModel
    private lazy var input = SearchViewModel.Input(
        searchTrigger: BehaviorRelay(value: viewModel.coinName)
    )
    private var disposeBag = DisposeBag()
    private lazy var output = viewModel.transform(input)
    
    weak var coordinator: SearchCoordinator?
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        coordinator?.popChild()
    }
    
    override func setBinding() {
        loadingIndicator.startAnimating()
        
        output.errorResult
            .drive(with: self) { owner, error in
                if (error == .decoding) || (error == .notFound) {
                    self.view.makeToast("검색 결과가 없습니다", duration: 1.5, position: .center)
                } else {
                    let vm = ErrorViewModel(notiType: .search)
                    let vc = ErrorViewController(viewModel: vm)
                    vm.delegate = owner
                    vc.configure(error)
                    vc.modalPresentationStyle = .overCurrentContext
                    owner.present(vc, animated: true)
                }
                owner.loadingIndicator.stopAnimating()
            }
            .disposed(by: disposeBag)
        
        let searchResult = output.searchResult.asDriver(onErrorJustReturn: [])
        
        searchResult
            .drive(tableView.rx.items(cellIdentifier: SearchTableViewCell.id, cellType: SearchTableViewCell.self)) { row, element, cell in
                cell.configure(element)
                cell.viewModel.delegate = self
            }
            .disposed(by: disposeBag)
        
        searchResult
            .drive(with: self) { owner, entity in
                if entity.isEmpty {
                    self.view.makeToast("검색 결과가 없습니다", duration: 1.5, position: .center)
                }
                owner.loadingIndicator.stopAnimating()
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(SearchEntity.self)
            .observe(on: MainScheduler.instance)
            .bind(with: self) { owner, entity in
                owner.coordinator?.pushDetail(entity.id)
            }
            .disposed(by: disposeBag)
        
        searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .withLatestFrom(searchTextField.rx.text.orEmpty)
            .withUnretained(self)
            .map { owner, text in
                return owner.viewModel.isValidSearchText(text)
            }
            .bind(with: self) { owner, text in
                guard let text = text else {
                    owner.searchTextField.text = owner.viewModel.coinName
                    owner.view.makeToast("한 글자 이상의 검색어를 입력하세요!", duration: 1, position: .center)
                    owner.loadingIndicator.startAnimating()
                    return
                }
                
                if owner.viewModel.coinName.isEqual(text) {
                    owner.view.makeToast("기존 검색어와 동일합니다!", duration: 1, position: .center)
                    owner.loadingIndicator.stopAnimating()
                } else {
                    owner.input.searchTrigger.accept(text)
                    owner.loadingIndicator.startAnimating()
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
        
        Observable.merge(
            swipeLeft.rx.event.map { _ in
                UISwipeGestureRecognizer.Direction.left },
            swipeRight.rx.event.map { _ in
                UISwipeGestureRecognizer.Direction.right }
        )
        .bind(with: self) { owner, direction in
            owner.swipeToggleButton(direction)
        }
        .disposed(by: disposeBag)
    }
    
    override func configureView() {
        self.navigationItem.titleView = searchTextField
        
        searchTextField.text = viewModel.coinName
        searchTextField.textAlignment = .left
        categoryView.backgroundColor = .white
        swipeLeft.direction = .left
        swipeRight.direction = .right
        
        configureTableView()
    }
    
    override func configureHierarchy() {
        [categoryView, tableView, loadingIndicator].forEach { self.view.addSubview($0) }
        [swipeLeft, swipeRight].forEach {
            self.view.addGestureRecognizer($0)
        }
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
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    deinit {
        print(#function, self)
    }
    
}

extension SearchViewController: ToastDelegate, ErrorDelegate {
    
    private func configureTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = 70
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
    }
    
    private func toggleButton(_ button: UIButton) {
        guard let text = searchTextField.text else { return }
        categoryButtons.forEach {
            $0.isSelected = false
            if $0.isEqual(button) {
                $0.isSelected = true
                if button.isEqual(categoryView.coinCategory) {
                    input.searchTrigger.accept(text)
                } else {
                    output.searchResult.accept([])
                }
            }
        }
    }
    
    private func swipeToggleButton(_ direction: UISwipeGestureRecognizer.Direction) {
        guard let selectedIndex = categoryButtons.firstIndex(where: { $0.isSelected }) else { return }
        
        var newIndex = selectedIndex
        if direction == .left {
            newIndex = min(selectedIndex + 1, categoryButtons.count - 1)
        } else if direction == .right {
            newIndex = max(selectedIndex - 1, 0)
        }
        
        if newIndex != selectedIndex {
            toggleButton(categoryButtons[newIndex])
        }
    }

    func toastMessage(_ message: String) {
        print(#function)
        self.view.makeToast(message, duration: 1, position: .center)
    }
    
    func reloadNetwork(type: ErrorSenderType) {
        guard let text = searchTextField.text else { return }
        switch type {
        case .search:
            input.searchTrigger.accept(text)
        default:
            break
        }
    }
    
}
