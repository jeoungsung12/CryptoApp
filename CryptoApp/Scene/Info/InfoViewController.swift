//
//  InfoViewController.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Toast
import NVActivityIndicatorView

final class InfoViewController: BaseViewController {
    private let loadingIndicator = NVActivityIndicatorView(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)), type: .ballPulseSync, color: .customDarkGray)
    private lazy var coinCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout(.popularSearch))
    private lazy var nftsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout(.popularNFT))
    private let searchBar = CustomSearchBar()
    private let coinSectionLabel = UILabel()
    private let nftSectionLabel = UILabel()
    private let timeStampLabel = UILabel()
    
    private let viewModel = InfoViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        viewModel.checkTimer(output.timeStamp.value, input)
    }
    
    override func setBinding() {
        let input = InfoViewModel.Input(
            reloadTrigger: PublishRelay()
        )
        let output = viewModel.transform(input)
        input.reloadTrigger.accept(())
        
        input.reloadTrigger
            .asDriver(onErrorJustReturn: ())
            .drive(with: self, onNext: { owner, _ in
                owner.loadingIndicator.startAnimating()
            })
            .disposed(by: disposeBag)
        
        Observable<Int>.timer(.seconds(600), scheduler: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.viewModel.checkTimer(output.timeStamp.value, input)
            }
            .disposed(by: disposeBag)
        
        //TODO: 어떨때되고 어떨때는안됨.
        Observable.merge(
            searchBar.searchTextField.rx.controlEvent(.editingDidEndOnExit).map { _ in () },
            searchBar.searchButton.rx.tap.map { _ in () }
        )
        .withUnretained(self)
        .map { owner, _ in
            owner.viewModel.isValidSearchText(owner.searchBar.searchTextField.text)
        }
        .asDriver(onErrorJustReturn: nil )
        .drive(with: self) { owner, text in
            guard let text = text else {
                owner.view.makeToast("한 글자 이상의 검색어를 입력하세요!", duration: 1, position: .center)
                return
            }
            let vm = SearchViewModel(coinName: text)
            let vc = SearchViewController(viewModel: vm)
            owner.searchBar.searchTextField.text = nil
            owner.navigationController?.pushViewController(vc, animated: true)
        }
        .disposed(by: disposeBag)
        
        coinCollectionView.rx.modelSelected(PopularCoinEntity.self)
            .asDriver()
            .drive(with: self) { owner, entity in
                let vm = CoinDetailViewModel(coinId: entity.id)
                let vc = CoinDetailViewController(viewModel: vm)
                //TODO: Coordinate
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.timeStamp
            .observe(on: MainScheduler.instance)
            .bind(with: self) { owner, time in
                //                owner.loadingIndicator.stopAnimating()
                owner.timeStampLabel.text = .dateToString(time)
            }
            .disposed(by: disposeBag)
        
        output.coinResult
            .drive(coinCollectionView.rx.items(cellIdentifier: CoinCollectionViewCell.id, cellType: CoinCollectionViewCell.self)) { items, element, cell in
                cell.configure(element, items)
            }
            .disposed(by: disposeBag)
        
        output.nftsResult
            .drive(nftsCollectionView.rx.items(cellIdentifier: NftsCollectionViewCell.id, cellType: NftsCollectionViewCell.self)) { items, element, cell in
                cell.configure(element)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        self.setNavigation(title: "가상자산 / 심볼 검색")
        self.view.backgroundColor = .white
        
        coinSectionLabel.text = "인기 검색어"
        nftSectionLabel.text = "인기 NFT"
        [coinSectionLabel, nftSectionLabel].forEach {
            $0.textColor = .customDarkGray
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 15, weight: .heavy)
        }
        
        timeStampLabel.textColor = .customGray
        timeStampLabel.textAlignment = .right
        timeStampLabel.font = .systemFont(ofSize: 13, weight: .regular)
        configureCollectionView()
    }
    
    override func configureHierarchy() {
        [searchBar, coinSectionLabel, timeStampLabel, coinCollectionView, nftSectionLabel, nftsCollectionView, loadingIndicator].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(45)
        }
        
        coinSectionLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(24)
        }
        
        timeStampLabel.snp.makeConstraints { make in
            make.bottom.equalTo(coinSectionLabel.snp.bottom)
            make.trailing.equalToSuperview().inset(24)
        }
        
        coinCollectionView.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(3)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(coinSectionLabel.snp.bottom).offset(24)
        }
        
        nftSectionLabel.snp.makeConstraints { make in
            make.top.equalTo(coinCollectionView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        nftsCollectionView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.horizontalEdges.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().inset(12)
            make.top.equalTo(nftSectionLabel.snp.bottom).offset(24)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    deinit {
        print(#function, self)
    }
}

extension InfoViewController {
    
    private func configureCollectionView() {
        coinCollectionView.backgroundColor = .white
        coinCollectionView.isScrollEnabled = false
        nftsCollectionView.backgroundColor = .white
        nftsCollectionView.isScrollEnabled = true
        nftsCollectionView.showsHorizontalScrollIndicator = false
        coinCollectionView.register(CoinCollectionViewCell.self, forCellWithReuseIdentifier: CoinCollectionViewCell.id)
        nftsCollectionView.register(NftsCollectionViewCell.self, forCellWithReuseIdentifier: NftsCollectionViewCell.id)
    }
    
    private func createLayout(_ type: Item) -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        switch type {
        case .popularSearch:
            let spacing: Double = 24
            let width = (UIScreen.main.bounds.width - (spacing * 3)) / 2
            layout.itemSize = CGSize(width: width, height: 30)
            layout.minimumLineSpacing = 24
            layout.minimumInteritemSpacing = 12
            layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
            
        case .popularNFT:
            layout.itemSize = CGSize(width: 72, height: 150)
            layout.minimumLineSpacing = 12
            layout.minimumInteritemSpacing = 12
            layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        }
        return layout
    }
    
}
