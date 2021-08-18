//
//  SceneDelegate.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let transitionManger = CardTransitionManager()
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let rootViewController = SplashViewController()
        rootViewController.reactor = SplashReactor()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        let navi = NaviController.navigationController
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

extension SceneDelegate: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            print("@@ operation == .push")
            return transitionManger
        } else if operation == .pop  {
            print("@@ operation == .pop")
            return nil
        } else {
            print("@@ operation == .none")
            return nil
        }
    }
}

