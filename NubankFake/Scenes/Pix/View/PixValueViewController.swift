//
//  PixValueViewController.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

import UIKit

final class PixValueViewController: UIViewController {
    
    weak var coordinator: PixCoordinator?
    
    // MARK: - Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Digite o valor"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currencyPrefixLabel: UILabel = {
        let label = UILabel()
        label.text = "R$"
        label.font = .systemFont(ofSize: 36, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0,00"
        textField.font = .systemFont(ofSize: 36, weight: .semibold)
        textField.textAlignment = .left
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 18
        return textField
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continuar", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.95)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Valor do Pix"
        setupView()
        setupLayout()
        setupActions()
    }
    
    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(currencyPrefixLabel)
        view.addSubview(valueTextField)
        view.addSubview(continueButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            currencyPrefixLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 80),
            currencyPrefixLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            
            valueTextField.centerYAnchor.constraint(equalTo: currencyPrefixLabel.centerYAnchor),
            valueTextField.leadingAnchor.constraint(equalTo: currencyPrefixLabel.trailingAnchor, constant: 8),
            valueTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            continueButton.topAnchor.constraint(equalTo: valueTextField.bottomAnchor, constant: 100),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupActions() {
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func didTapContinue() {
        guard let text = valueTextField.text?
            .replacingOccurrences(of: ",", with: "."),
              let value = Double(text) else {
            // TODO: Exibir alerta de valor inválido
            let alert = UIAlertController(title: "Valor inválido",
                                          message: "Digite um valor numérico válido.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        // Chama o próximo passo no coordinator
        coordinator?.showSecondPixConfirmationScreen(valueToConfirm: value)
    }
}
