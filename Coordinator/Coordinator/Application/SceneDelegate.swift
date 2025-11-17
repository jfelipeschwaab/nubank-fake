//
//  SceneDelegate.swift
//  Coordinator
//
//  Created by Débora Cristina Silva Ferreira on 06/11/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        guard let winScene = (scene as? UIWindowScene) else {return}
        window = UIWindow(windowScene: winScene)
        let nav = UINavigationController()

        coordinator = AppCoordinator(navigationController: nav)
        
        coordinator?.start()
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
    }
}

