//
//  PixConfirmationViewController.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

import UIKit
import Combine

final class PixConfirmationViewController: UIViewController {
    
    private var viewModel: PixRecipientViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Properties
    private var pixData: PixData?
    private var hasValue: Bool //
    private var value: Double? //
    
    // MARK: - Init
    
    /// Novo Init para MVVM (usado por `showPixConfirmationScreen`)
    init(viewModel: PixRecipientViewModel, hasValue: Bool = false, value: Double? = nil) { //
        self.viewModel = viewModel //
        self.hasValue = hasValue
        self.value = value
        super.init(nibName: nil, bundle: nil) //
    }
    
    /// Init existente (usado por `showSecondPixConfirmationScreen`)
    init(hasValue: Bool = false, value: Double? = nil) { //
        self.hasValue = hasValue
        self.value = value
        self.pixData = nil
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
        label.text = "Nome completo"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameValueLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cidadeLabel: UILabel = {
        let label = UILabel()
        label.text = "Cidade"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cidadeValueLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cpfLabel: UILabel = {
        let label = UILabel()
        label.text = "CPF"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cpfValueLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bankLabel: UILabel = {
        let label = UILabel()
        label.text = "Instituição"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bankValueLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = "Valor"
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

        if viewModel != nil {
            setupBindings()
        }
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        var subviews: [UIView] = [
            titleLabel,
            nameLabel, nameValueLabel,
            cidadeLabel, cidadeValueLabel,
            cpfLabel, cpfValueLabel,
            bankLabel, bankValueLabel
        ]

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
            
            cidadeLabel.topAnchor.constraint(equalTo: nameValueLabel.bottomAnchor, constant: 20),
            cidadeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            cidadeValueLabel.topAnchor.constraint(equalTo: cidadeLabel.bottomAnchor, constant: 4),
            cidadeValueLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            cpfLabel.topAnchor.constraint(equalTo: cidadeValueLabel.bottomAnchor, constant: 20),
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

    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        
        viewModel.$recipientName
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newName in
                self?.nameValueLabel.text = newName
            }
            .store(in: &cancellables)
        
        viewModel.$cidade
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newCidade in
                self?.cidadeValueLabel.text = newCidade
            }
            .store(in: &cancellables)
        
        viewModel.$recipientCPF
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newCPF in
                self?.cpfValueLabel.text = newCPF
            }
            .store(in: &cancellables)
        
        viewModel.$recipientBank
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newBank in
                self?.bankValueLabel.text = newBank
            }
            .store(in: &cancellables)
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
            viewModel?.didTapConfirm()
        }
    }
    
    @objc private func didTapCancel() {
        navigationController?.popViewController(animated: true)
    }
}
