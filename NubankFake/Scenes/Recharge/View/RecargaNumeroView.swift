//
//  File.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

import Foundation
import UIKit

class RecargaNumeroView: UIViewController {
    //so conhece a viewModel
    private let viewModel: RecargaNumeroViewModel
    
    // UI Simples
    lazy var numeroTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Seu número (9 dígitos)"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .phonePad
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        // Conectando com a viewModel
       // Quando o texto mudar, avise o ViewModel
       tf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return tf
    }()
    
    lazy var proximoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Próximo", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
       
        // Conectando com a viewModel
        // Quando o botão for tocado, avise o ViewModel
        button.addTarget(self, action: #selector(proximoTocado), for: .touchUpInside)
        return button
    }()
    
    // A View precisa receber o ViewModel para existir
    init(viewModel: RecargaNumeroViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recarga"
        view.backgroundColor = .white
        setupUI()
    }
    
    // Função para organizar a UI
    private func setupUI() {
        view.addSubview(numeroTextField)
        view.addSubview(proximoButton)
        
        NSLayoutConstraint.activate([
            numeroTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numeroTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            numeroTextField.widthAnchor.constraint(equalToConstant: 250),
            
            proximoButton.topAnchor.constraint(equalTo: numeroTextField.bottomAnchor, constant: 20),
            proximoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        // View avisa o ViewModel: "O texto mudou!"
        viewModel.numeroDigitado = textField.text ?? ""
    }
    
    @objc private func proximoTocado() {
        // View avisa o ViewModel: "O botão foi tocado!"
        viewModel.botaoProximoTocado()
    }
}

