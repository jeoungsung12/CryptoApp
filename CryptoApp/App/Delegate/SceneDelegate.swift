//
//  SceneDelegate.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit

protocol ErrorSceneDelegate: AnyObject {
    func reloadNetwork()
}

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var errorWindow: UIWindow?
    
    weak var errorDelegate: ErrorSceneDelegate?
    private var networkMonitor: NetworkMonitorManagerType = NetworkMonitorManager()
    private let errorView = ErrorViewController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        
        networkMonitor.startMonitoring { [weak self] status in
            switch status {
            case .satisfied:
                self?.dismissErrorView()
                self?.errorDelegate?.reloadNetwork()
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
    
    func sceneDidDisconnect(_ scene: UIScene) {
        networkMonitor.stopMonitoring()
    }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

}

