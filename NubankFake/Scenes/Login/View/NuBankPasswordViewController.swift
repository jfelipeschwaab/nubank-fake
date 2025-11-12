//
//  NuBankPasswordViewController.swift
//  NubankFake
//
//  Created by Letícia Delmilio Soares on 12/11/25.
//

import UIKit

//fazer ela ser chamada pelo coordinator

class NuBankPasswordViewController: UIViewController {
    
 //   private let coordinator: LoginCoordinator

    var didEnterPassword: ((String) -> Void)?
    
    // Closure que o Coordinator chamará para notificar um erro
        var didFailAuth: (() -> Void)?
    
//    // Recebe o serviço no construtor (Injeção de Dependência)
//    init(coordinator: LoginCoordinator) {
//        self.coordinator = coordinator
//        super.init(nibName: nil, bundle: nil) // chama o inicializador da UIViewController
//    }
//
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    private let passwordField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Digite sua senha do Nubank"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let submitButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Entrar", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //BOTÃO X
    private let closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("X", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(passwordField)
        view.addSubview(submitButton)
        view.addSubview(closeButton)
        
        setupConstraints()
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([ //Recebe um array de constraints e ativa todas de uma vez.Sem isso, as constraints existem mas não “funcionam” na tela.
            
            /**topAnchor → define a distância do topo do botão até o topo seguro (safeAreaLayoutGuide.topAnchor) da tela.
             constant: 16 → 16 pontos abaixo do topo seguro.
             trailingAnchor → distância da borda direita da tela (view.trailingAnchor).*/
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -350),
            
            //TEXTFIELD
            passwordField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            submitButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func submitTapped() {
            guard let password = passwordField.text else { return }
            
            // APENAS envia a senha para o Coordinator
            didEnterPassword?(password)
        }
    
    // limpa o campo e mostra o erro
        func handleAuthFailure() {
            // Limpa o campo para nova tentativa
            passwordField.text = ""
        
            
            let alert = UIAlertController(title: "Erro de Autenticação", message: "A senha do Nubank está incorreta. Tente novamente.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
}
