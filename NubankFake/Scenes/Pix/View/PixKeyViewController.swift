//
//  PixKeyViewController.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//


import UIKit
import Combine

final class PixKeyViewController: UIViewController {
    
    var viewModel : PixKeyViewModel
    private var cancellables = Set<AnyCancellable>()

    
    init(viewModel: PixKeyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Digite a chave Pix"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let keyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "exemplo@email.com"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let continueButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Continuar", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.9)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chave Pix"
        setupView()
        setupLayout()
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        keyTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        setupBindings()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(keyTextField)
        view.addSubview(continueButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            keyTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            keyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            keyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            keyTextField.heightAnchor.constraint(equalToConstant: 44),

            continueButton.topAnchor.constraint(equalTo: keyTextField.bottomAnchor, constant: 30),
            continueButton.leadingAnchor.constraint(equalTo: keyTextField.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: keyTextField.trailingAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc private func didTapContinue() {
        viewModel.validateKey()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        viewModel.key = textField.text ?? ""
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func setupBindings() {
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.showAlert(message: message)
            }
            .store(in: &cancellables)
    }
}

