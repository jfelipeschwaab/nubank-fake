//
//  PixConfirmationViewController.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

import UIKit

final class PixConfirmationViewController: UIViewController {
    
    weak var coordinator: PixCoordinator?
    
    // MARK: - Properties
    private var hasValue: Bool
    private var value: Double?
    
    // MARK: - Init
    init(hasValue: Bool = false, value: Double? = nil) {
        self.hasValue = hasValue
        self.value = value
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirme os dados do destinatário"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nome completo" // TODO: substituir por dados da VM
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameValueLabel: UILabel = {
        let label = UILabel()
        label.text = "João da Silva" // TODO: substituir por dados da VM
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cpfLabel: UILabel = {
        let label = UILabel()
        label.text = "CPF" // TODO: substituir por dados da VM
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cpfValueLabel: UILabel = {
        let label = UILabel()
        label.text = "123.456.789-00" // TODO: substituir por dados da VM
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bankLabel: UILabel = {
        let label = UILabel()
        label.text = "Instituição" // TODO: substituir por dados da VM
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bankValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Nu Pagamentos S.A. (260)" // TODO: substituir por dados da VM
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = "Valor" // TODO: substituir por dados da VM
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valueValueLabel: UILabel = {
        let label = UILabel()
        if let value = value {
            label.text = String(format: "R$ %.2f", value)
        } else {
            label.text = "R$ 0,00"
        }
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirmar", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.95)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancelar", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.setTitleColor(.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = hasValue ? "Revisar transferência" : "Confirmação"
        setupView()
        setupLayout()
        setupActions()
    }
    
    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = .systemBackground
        var subviews: [UIView] = [
            titleLabel,
            nameLabel, nameValueLabel,
            cpfLabel, cpfValueLabel,
            bankLabel, bankValueLabel
        ]
        
        // Se houver valor, adiciona também os labels de valor
        if hasValue {
            subviews.append(contentsOf: [valueLabel, valueValueLabel])
        }
        
        subviews.append(contentsOf: [confirmButton, cancelButton])
        subviews.forEach(view.addSubview)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            nameValueLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            nameValueLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            cpfLabel.topAnchor.constraint(equalTo: nameValueLabel.bottomAnchor, constant: 20),
            cpfLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            cpfValueLabel.topAnchor.constraint(equalTo: cpfLabel.bottomAnchor, constant: 4),
            cpfValueLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            bankLabel.topAnchor.constraint(equalTo: cpfValueLabel.bottomAnchor, constant: 20),
            bankLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            bankValueLabel.topAnchor.constraint(equalTo: bankLabel.bottomAnchor, constant: 4),
            bankValueLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
        ])
        
        if hasValue {
            NSLayoutConstraint.activate([
                valueLabel.topAnchor.constraint(equalTo: bankValueLabel.bottomAnchor, constant: 20),
                valueLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                
                valueValueLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4),
                valueValueLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                
                confirmButton.topAnchor.constraint(equalTo: valueValueLabel.bottomAnchor, constant: 60),
            ])
        } else {
            NSLayoutConstraint.activate([
                confirmButton.topAnchor.constraint(equalTo: bankValueLabel.bottomAnchor, constant: 60),
            ])
        }
        
        NSLayoutConstraint.activate([
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
            
            cancelButton.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 20),
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupActions() {
        confirmButton.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func didTapConfirm() {
        if hasValue {
            // TODO: finalizar transação ou mostrar tela de sucesso
            let alert = UIAlertController(
                title: "Transferência enviada!",
                message: "O valor foi transferido com sucesso ✅",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Fechar", style: .default))
            present(alert, animated: true)
        } else {
            coordinator?.showPixValueScreen()
        }
    }
    
    @objc private func didTapCancel() {
        navigationController?.popViewController(animated: true)
    }
}
