//
//  RecargaPayment2.swift
//  NubankFake
//
//  Created by Keitiely Silva Viana on 12/11/25.
//

import UIKit

class RecargaFormaPag2View: UIViewController {

    
    private let viewModel: RecargaPaymentViewModel

    // --- UI Simples ---
    private lazy var valor20Button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("R$ 20,00", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(valor20Tocado), for: .touchUpInside)
        return button
    }()
    
    private lazy var valor50Button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("R$ 50,00", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(valor50Tocado), for: .touchUpInside)
        return button
    }()
    
    private lazy var recarregarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Recarregar", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(recarregarTocado), for: .touchUpInside)
        return button
    }()
    // ------------------
    
    // A view precisa receber a viewmodel
    init(viewModel: RecargaPaymentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Escolha o Valor"
        view.backgroundColor = .white
        setupUI()
        
        bindViewModel()
    }
    
    private func setupUI() {
        // (O mesmo setup de antes, com StackView)
        let stackView = UIStackView(arrangedSubviews: [valor20Button, valor50Button])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(recarregarButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            recarregarButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            recarregarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    
    // 2. ADICIONE ESSA NOVA FUNÇÃO
    private func bindViewModel() {
        // "Ouvindo" o estado de carregamento da ViewModel
        viewModel.isLoading = { [weak self] (carregando) in
            
            // Sempre atualize a UI na thread principal!
            DispatchQueue.main.async {
                // Desativa o botão se estiver carregando
                self?.recarregarButton.isEnabled = !carregando
                
                // Bônus: Muda o texto para dar feedback ao usuário
                if carregando {
                    self?.recarregarButton.setTitle("Recarregando...", for: .disabled)
                } else {
                    self?.recarregarButton.setTitle("Recarregar", for: .normal)
                }
            }
        }
    }
    // --- Ações da View (que só repassam para o ViewModel) ---

    @objc private func valor20Tocado() {
        viewModel.selecionarValor(20.0)
    }
    
    @objc private func valor50Tocado() {
        viewModel.selecionarValor(50.0)
    }
    
    @objc private func recarregarTocado() {
        // Avisa o ViewModel para fazer a ação final
        viewModel.botaoRecarregarTocado()
    }
}
