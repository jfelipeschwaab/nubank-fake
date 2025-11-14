//
//  LoginView.swift
//  NubankFake
//
//  Created by Letícia Delmilio Soares on 11/11/25.
//

import UIKit

class LoginView: UIView {
    
    // MARK: - Componentes de UI
    
    // O Botão principal (Face ID/Passcode)
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Inserir Senha / Usar Face ID", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
  
    
    // Botão Login Nubank
    lazy var nubankLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Entrar com Senha do Nubank", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true // Escondido no início, visibilidade controlada pelo VC/VM
        return button
    }()
    
    // MARK: - Inicialização
    
    // frame: .zero é o padrão para ViewCode
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground // Fundo definido na View
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewCode Métodos
    
    private func setupHierarchy() {
        let stackView = UIStackView(arrangedSubviews: [loginButton, nubankLoginButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        // Para simplificar, usamos a StackView do setupHierarchy
        let stackView = self.subviews.first as! UIStackView
        
        NSLayoutConstraint.activate([
            // Centraliza o conjunto de elementos
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            
        ])
    }
    
    // MARK: - Métodos de Exposição de UI
    
    // Método que o ViewController vai chamar para alterar o estado
    func showNuBankFields(_ show: Bool) {
        nubankLoginButton.isHidden = !show
    }
}
