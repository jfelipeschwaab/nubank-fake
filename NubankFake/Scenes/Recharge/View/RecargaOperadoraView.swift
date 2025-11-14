//
//  OperadorViewModel.swift
//  NubankFake
//
//  Created by Keitiely Silva Viana on 12/11/25.
//
import Foundation
import UIKit

class RecargaOperadoraView: UIViewController {

    // so conhece a ViewModel dela
    private let viewModel: RecargaOperadoraViewModel

    

    // --- UI Simples ---
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Qual a operadora para o número:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numeroLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        // A View "lê" o estado inicial do ViewModel
        label.text = viewModel.numero
        return label
    }()
    
    // Botões das operadoras
    private lazy var timButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tim", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        // 3. CONECTANDO A AÇÃO
        button.addTarget(self, action: #selector(timTocado), for: .touchUpInside)
        return button
    }()
    
    private lazy var claroButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Claro", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(claroTocado), for: .touchUpInside)
        return button
    }()
    
    private lazy var vivoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Vivo", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
            //avisando
        button.addTarget(self, action: #selector(vivoTocado), for: .touchUpInside)
        return button
    }()

    
    // A View precisa receber o ViewModel avisa
    init(viewModel: RecargaOperadoraViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Operadora"
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(infoLabel)
        view.addSubview(numeroLabel)
        
        // Usando uma StackView para organizar os botões
        let stackView = UIStackView(arrangedSubviews: [timButton, claroButton, vivoButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            numeroLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            numeroLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: numeroLabel.bottomAnchor, constant: 30),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    //Ações da View que só repassam para o ViewModel
    
    @objc private func timTocado() {
        // View avisa o Cérebro: "Botão Tim tocado!"
        viewModel.selecionarOperadora(operadora: .tim)
    }
    
    @objc private func claroTocado() {
        viewModel.selecionarOperadora(operadora: .claro)
    }
    
    @objc private func vivoTocado() {
        viewModel.selecionarOperadora(operadora: .vivo)
    }
}
