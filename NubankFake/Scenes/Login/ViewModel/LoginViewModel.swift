//
//  LoginViewModel.swift
//  NubankFake
//
//  Created by Letícia Delmilio Soares on 11/11/25.
//

import Foundation
import LocalAuthentication

class LoginViewModel {
    
    private let coordinator: LoginCoordinator
    //O Serviço de Autenticação
    private let authService: LocalAuthServiceProtocol
    // Variável para rastrear as falhas de Face ID
    
    private var authenticationAttemptCount = 0
    private let maxAttempts = 3 //max de tentativas de falha do face id
    
    // ViewModel
    var shouldShowNuBankPassword: ((Bool) -> Void)?

   
    
    // Recebe o serviço no construtor (Injeção de Dependência)
    init(coordinator: LoginCoordinator, authService: LocalAuthServiceProtocol) {
        self.coordinator = coordinator
        self.authService = authService
    }
    
    func goToHome() {
        coordinator.didFinishedLogin()
    }
}


extension LoginViewModel {
    
    // função chamada pelo LoginViewController quando o usuário CANCELA o Face ID
    func didTapPasswordButton() {
        //  Pede ao Coordinator para abrir a nova tela de senha
        coordinator.showNuBankPasswordScreen()
    }
    
    func authenticateWithFaceID() {
        print("começou a autenticação de face ID no model")
        
        let reason = "Para sua segurança, use o Face ID para acessar sua conta."
        
        //  O ViewModel DELEGA a tarefa para o Serviço
        authService.authenticate(reason: reason) { [weak self] result in
            
            switch result {
            case .success(let account):
                // SUCESSO! Chama o Coordinator
                self?.coordinator.userDidAuthenticateSuccessfully(account: account)
                self?.goToHome()
                
            case .failure(let laError):
                // FALHA! Manipula o erro (agora um LAError)
                self?.handleAuthenticationFailure(error: laError)
                
            }
        }
    }
    
    func validateNuBankPassword(_ password: String) {
        // Exemplo
        if password == "1234" {
            if let user = AuthService.shared.validate(password: password) {
                coordinator.userDidAuthenticateSuccessfully(account: user)
                print("entrou aqui")
                goToHome()
            } else {
                print("Senha incorreta")
                print("entrou aqui")

                // Pode chamar outro alert ou incrementar tentativas
            }
        }
    }
    
    func handleAuthenticationFailure(error: Error?) {
        guard let error = error else { return }
        let laError = LAError(_nsError: error as NSError)
        
        // Incrementa tentativas apenas se a biometria falhou
        if laError.code == .authenticationFailed {
            if authenticationAttemptCount >= maxAttempts {
                print("Esgotadas tentativas. Navegando para Senha do Nubank.")
                coordinator.showNuBankPasswordScreen()
            }
        }
        
        // Se o usuário cancelou
        if laError.code == .userCancel {
            print("Usuário cancelou o login com a senha do iPhone. Indo para Senha do Nubank.")
            coordinator.showNuBankPasswordScreen() // CHAMA O COORDINATOR
            
        }
    }
    
    func validateNubankPassword(_ password: String) {
        
    }
}
    

