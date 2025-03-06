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

final class InfoViewController: BaseViewController {
    private let searchBar = UISearchBar()
    private lazy var coinCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout(.popularSearch))
    private lazy var nftsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout(.popularNFT))
    
    private let viewModel = InfoViewModel()
    private var disposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section,Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setBinding() {
        let input = InfoViewModel.Input(
            reloadTrigger: PublishRelay()
        )
        let output = viewModel.transform(input)
        input.reloadTrigger.accept(())
        
        output.popularReslut
            .drive(with: self) { owner, entity in
                dump(entity)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        self.setNavigation(title: "가상자산 / 심볼 검색")
        self.view.backgroundColor = .white
        configureCollectionView()
    }
    
    override func configureHierarchy() {
        [searchBar, coinCollectionView, nftsCollectionView].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(50)
        }
        
        coinCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(12)
            make.height.equalToSuperview().dividedBy(2)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
        
        nftsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(coinCollectionView.snp.bottom).offset(12)
            make.bottom.horizontalEdges.equalToSuperview().inset(12)
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
        nftsCollectionView.showsHorizontalScrollIndicator = false
        coinCollectionView.register(CoinCollectionViewCell.self, forCellWithReuseIdentifier: CoinCollectionViewCell.id)
        nftsCollectionView.register(NftsCollectionViewCell.self, forCellWithReuseIdentifier: NftsCollectionViewCell.id)
    }
    
    private func createLayout(_ type: Item) -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        switch type {
        case .popularSearch:
            let spacing: Double = 12
            let width = (UIScreen.main.bounds.width - spacing) / 2
            layout.itemSize = CGSize(width: width, height: 30)
            layout.minimumLineSpacing = 12
            layout.minimumInteritemSpacing = 12
            layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
            
        case .popularNFT:
            let spacing: Double = 12
            let width = (UIScreen.main.bounds.width - (spacing * 5)) / 4.5
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: width, height: width)
            layout.minimumLineSpacing = 12
            layout.minimumInteritemSpacing = 12
            layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        }
        return layout
    }
    
}
