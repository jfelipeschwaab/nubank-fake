//  AppCoordinator.swift
//  NubankFake
//  Created by João Felipe Schwaab on 11/11/25.

import Foundation
import UIKit

final class AppCoordinator : Coordinator {
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    private var window: UIWindow

    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {

        window.rootViewController = navigationController //define a Janela Principal (window) para ser controlada pelo Navegador (navigationController). O Navegador é agora o ponto de partida de tudo.
        window.makeKeyAndVisible() //Liga a tela, O aplicativo agora aparece para o usuário.
        showLogin()

    }
    
    func showLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController) //cria o loginCoordinator
        loginCoordinator.parentCoordinator = self
        childCoordinators.append(loginCoordinator) // add como filho
        loginCoordinator.start() //começa o fluxo do login
    }

    func showHomeCoordinator(){
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.parentCoordinator = self
        homeCoordinator.start()
        childCoordinators.append(homeCoordinator)
    }
    
}
