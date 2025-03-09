//
//  BaseViewController.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    private let networkMonitor: NetworkMonitorManagerType = NetworkMonitorManager.shared
    let reloadTrigger: PublishRelay<Void> = PublishRelay()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNetworkMonitor()
        configureView()
        configureHierarchy()
        configureLayout()
        setBinding()
    }
    
    func setBinding() { }
    func configureView() { }
    func configureHierarchy() { }
    func configureLayout() { }
    
    deinit {
        networkMonitor.stopMonitoring()
    }
}

extension BaseViewController {
    
    func setNetworkMonitor() {
        networkMonitor.startMonitoring { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .satisfied:
                self.dismissNetworkErrorView()
                self.reloadTrigger.accept(())
            case .unsatisfied:
                self.presentNetworkErrorView()
            default:
                break
            }
        }
    }
    
    private func presentNetworkErrorView() {
        if self.presentedViewController is ErrorViewController { return }
        
        let vc = ErrorViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    private func dismissNetworkErrorView() {
        if let vc = self.presentedViewController as? ErrorViewController {
            vc.dismiss(animated: true)
        }
    }
    
}
