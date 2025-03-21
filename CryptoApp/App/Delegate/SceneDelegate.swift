//
//  SceneDelegate.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    private var networkMonitor: NetworkMonitorManagerType = NetworkMonitorManager()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        sleep(2)
        
        let window = UIWindow(windowScene: scene)
        self.window = window
        
        let nv = UINavigationController()
        let appCoordinator = AppCoordinator(window: window, navigationController: nv)
        self.appCoordinator = appCoordinator
        appCoordinator.start()
        
        networkMonitor.startMonitoring { [weak self] status in
            switch status {
            case .satisfied:
                self?.dismissErrorView(scene: scene)
            case .unsatisfied:
                self?.presentErrorView(scene: scene)
            default:
                break
            }
        }
    }
    
    private func presentErrorView(scene: UIScene) {
        if let windowScene = scene as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            DispatchQueue.main.async {
                let errorViewController = ErrorViewController(viewModel: ErrorViewModel(notiType: .network), errorType: NSError())
                errorViewController.modalPresentationStyle = .overCurrentContext
                rootViewController.present(errorViewController, animated: true, completion: nil)
            }
        }
    }
    
    private func dismissErrorView(scene: UIScene) {
        if let windowScene = scene as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            DispatchQueue.main.async {
                rootViewController.dismiss(animated: true)
            }
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

