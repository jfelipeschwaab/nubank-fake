//
//  LoginViewController.swift
//  NubankFake
//
//  Created by Letícia Delmilio Soares on 11/11/25.
//

import UIKit

final class LoginViewController: UIViewController {
    /**É uma UIViewController (um controlador de tela do UIKit) e o uso de final significa que ela não pode ser herdada.**/
    // MARK: - Acesso à View concreta
    var loginView: LoginView {
        return view as! LoginView
    }
    /**Uma propriedade computed (calculada) que faz o type casting (as!) da view padrão do Controller para a sua classe  (LoginView). Permite ao Controller acessar diretamente os elementos e métodos da View.**/
    
    // MARK: - Dependências
    private let viewModel: LoginViewModel //o Controller depende do ViewModel, que contém a lógica.
    
    // MARK: - Inicialização
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Sobrescreve o método padrão do UIKit. Em vez de carregar um arquivo .xib ou storyboard, ele cria programaticamente a sua LoginView (self.view = LoginView()) e a define como a view raiz do Controller.
    override func loadView() {
        self.view = LoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple
        setupActions()
        bindViewModel()
    }
    
    
    // MARK: - Configurações
    private func setupActions() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.nubankLoginButton.addTarget(self, action: #selector(nubankLoginTapped), for: .touchUpInside)
    }
    
    private func bindViewModel() { //Configura o binding para reagir a uma mudança de estado no LoginViewModel.
        viewModel.shouldShowNuBankPassword = { [weak self] show in
            DispatchQueue.main.async {
                self?.loginView.showNuBankFields(show)
            }
        }
    }
    
    // MARK: - Ações de Usuário
    @objc private func loginButtonTapped() {
        print("Botão Face ID/Passcode pressionado.")
        viewModel.authenticateWithFaceID() //delega a tarefa ao ViewModel para autenticar 
    }
    
    @objc private func nubankLoginTapped() {
        print("Botão Senha Nubank pressionado.")
        viewModel.didTapPasswordButton() // Agora o VM pede ao Coordinator pra abrir a tela de senha
    }
}
