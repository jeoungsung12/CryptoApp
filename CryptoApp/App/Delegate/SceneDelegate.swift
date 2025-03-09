//
//  SceneDelegate.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var errorWindow: UIWindow?
    
    private var networkMonitor: NetworkMonitorManagerType = NetworkMonitorManager()
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        
        networkMonitor.startMonitoring { [weak self] status in
            switch status {
            case .satisfied:
                self?.dismissErrorView()
            case .unsatisfied:
                self?.presentErrorView(scene: scene)
            default:
                break
            }
        }
    }
    
    private func presentErrorView(scene: UIScene) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.windowLevel = .statusBar
            window.makeKeyAndVisible()
            
            
            let errorView = ErrorViewController(viewModel: ErrorViewModel(notiType: self.getTopScene()))
            if let networkErrorView = errorView.view {
                window.addSubview(networkErrorView)
                self.errorWindow = window
            }
        }
    }
    
    private func dismissErrorView() {
        errorWindow?.resignKey()
        errorWindow?.isHidden = true
        errorWindow = nil
    }
    
    private func getTopScene() -> ErrorSenderType {
        let window = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        
        guard let rootVC = window?.rootViewController else { return .none }
        if let _ = rootVC as? ExchangeViewController {
            return .exchange
        } else if let _ = rootVC as? InfoViewController {
            return .info
        } else if let _ = rootVC as? SearchViewController {
            return .search
        } else if let _ = rootVC as? CoinDetailViewController {
            return .detail
        } else {
            return .none
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        networkMonitor.stopMonitoring()
    }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

}

