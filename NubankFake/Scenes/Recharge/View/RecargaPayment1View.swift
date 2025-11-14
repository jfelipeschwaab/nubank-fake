//
//  RecargaFormaPag1View.swift
//  NubankFake
//
//  Created by Keitiely Silva Viana on 12/11/25.
//

import Foundation
import UIKit

class RecargaPayment1View: UIViewController {
    
    private let viewModel: RecargaPaymentViewModel
    
    // --- UI Simples ---
    private lazy var saldoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Saldo da Conta", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saldoTocado), for: .touchUpInside)
        return button
    }()
    
    private lazy var creditoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cartão de Crédito", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(creditoTocado), for: .touchUpInside)
        return button
    }()
    
    private lazy var confirmarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirmar", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(confirmarTocado), for: .touchUpInside)
        return button
    }()
    
    
    //View recebe ViewModel
    init(viewModel: RecargaPaymentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Forma de Pagamento"
        view.backgroundColor = .white
        setupUI()
        //para carregar os dados
        //  Diga para a View "ouvir" o ViewModel
        bindViewModel()
        
        // ViewModel "começar a carregar" os dados
        viewModel.carregarDados()
        // ---------------------------------
    }
    
    private func setupUI() {
        // Stack para os botões de seleção
        let stackView = UIStackView(arrangedSubviews: [saldoButton, creditoButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(confirmarButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            confirmarButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            confirmarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    // Carregar Dados
    
    // Conectar na view
    private func bindViewModel() {
    
        viewModel.dadosCarregados = { [weak self] in
            // O ViewModel avisou que os dados (saldo) chegaram!
            DispatchQueue.main.async {
                self?.atualizarBotoesUI()
            }
        }
        
      
        // View parar de "carregar"
        viewModel.didFail = { [weak self] erro in
            // (Aqui você pode mostrar um alerta, ou só dar print)
            print("ViewModel falhou: \(erro)")
    }
}
    
    //  Atualiza a UI com os dados do ViewModel
    private func atualizarBotoesUI() {
        print("VIEW: Dados carregados. Atualizando botões.")
            
            // Lógica do Cartão
            creditoButton.setTitle("Cartão de Crédito", for: .normal)
            creditoButton.isEnabled = true // Sempre habilitado
            
            // Lógica do Saldo (SÓ MOSTRA, NÃO DESABILITA)
            let saldoStr = String(format: "%.2f", viewModel.saldoDisponivel ?? 0)
            saldoButton.setTitle("Saldo da Conta (R$ \(saldoStr))", for: .normal)
            saldoButton.isEnabled = true // Sempre habilitado
    }
    
    
    
    
    //açoes da view que so manda pra ViewModel
    
    @objc private func saldoTocado(){
        viewModel.selectFormaPagamento(FormaPagamento.Saldo)
    }
    
    @objc private func creditoTocado(){
        viewModel.selectFormaPagamento(FormaPagamento.CartaoCredito)
    }
    
    @objc private func confirmarTocado(){
        viewModel.botaoConfirmarTocado()
    }
}
