
//  LoginCoordinator.swift
//  NunbankFake
//
//  Created by Letícia Delmilio Soares on 11/11/25.
//

import Foundation
import UIKit
import LocalAuthentication

class LoginCoordinator: Coordinator {
    
    func childDidFinish(_ child: (any Coordinator)?) {
        // Garantir que a referência do Coordinator não seja nula
            guard let child = child else { return }

            // Iterar sobre o array de childCoordinators
            if let index = childCoordinators.firstIndex(where: { $0 === child }) {
                // Remover o Coordinator filho da lista
                childCoordinators.remove(at: index)
            }
    }
    var parentCoordinator: (any Coordinator)?
    
    var navigationController: UINavigationController//É o guia do iOS (UINavigationController) que o Coordinator usa para empilhar e mostrar as telas
    var childCoordinators = [Coordinator]()
    
    // Closure para notificar o Coordinator pai (ex: AppCoordinator) que o fluxo terminou
    // Ele será chamado quando o login for bem-sucedido.
    var didFinishLogin: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        // Inicia o fluxo mostrando a primeira tela de Login/Face ID
        showLoginScreen()
    }

    //função é chamada pelo ViewModel quando aprovada (Face ID ou senha funcionou). Tudo o que ela faz é tocar o Sino (didFinishLogin?()) para que o AppCoordinator assuma o controle e mude para a tela Home.
    func userDidAuthenticateSuccessfully() {
        didFinishLogin?()
        
    }
}
extension LoginCoordinator {
    
    // MARK: Tela Inicial (Login/Face ID)
    func showLoginScreen() {
        // INJEÇÃO:
        let authService = LocalAuthService() // Cria o Serviço
        
        // Injeta o Serviço e o Coordinator
        let viewModel = LoginViewModel(coordinator: self, authService: authService)
        
        let viewController = LoginViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    
    // MARK: Fallback 2: Senha do Nubank
    func showNuBankPasswordScreen() {
        
        let nuBankVC = NuBankPasswordViewController()
        
        //  O Coordinator é quem decide o que acontece quando a senha é enviada
        nuBankVC.didEnterPassword = { [weak self] password in
            
            guard let self = self else { return }
            
            let authService = AuthService.shared
            
            if authService.validate(password: password) != nil {
                //  Sucesso
                print("Login Nubank com senha bem-sucedido. Fechando tela.")
                self.userDidAuthenticateSuccessfully()
                nuBankVC.dismiss(animated: true) //  FECHA a tela APENAS no sucesso
            } else {
                //  falha
                print("Senha do Nubank incorreta. Continua na tela.")
                
                //  CHAMA O MÉTODO DE TRATAMENTO DE ERRO na NuBankPasswordViewController
                nuBankVC.handleAuthFailure()
            }
        }
        
        // Apresenta a tela
        nuBankVC.modalPresentationStyle = .fullScreen
        self.navigationController.present(nuBankVC, animated: true)
    }
    /**TO-DO
     -builder
     **/
}
