//
//  PixValueViewController.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

import UIKit
import Combine

final class PixValueViewController: UIViewController {
    
    private let viewModel: PixValueViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Layout Properties
    // Armazenamos a constraint inferior para alterá-la quando o teclado aparecer
    private var continueButtonBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Init
    init(viewModel: PixValueViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        // Remove os observadores ao sair da tela
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Qual é o valor da transferência?"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currencyPrefixLabel: UILabel = {
        let label = UILabel()
        label.text = "R$"
        label.textColor = .lightGray
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
        button.backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transferir"
        setupView()
        setupLayout()
        setupActions()
        setupBindings()
        setupKeyboardObservers() // Configura a observação do teclado
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        valueTextField.becomeFirstResponder()
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
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            currencyPrefixLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            currencyPrefixLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            valueTextField.centerYAnchor.constraint(equalTo: currencyPrefixLabel.centerYAnchor),
            valueTextField.leadingAnchor.constraint(equalTo: currencyPrefixLabel.trailingAnchor, constant: 8),
            valueTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Define a constraint inicial (ancorada no bottom da view) e guarda a referência
        continueButtonBottomConstraint = continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        continueButtonBottomConstraint?.isActive = true
    }
    
    private func setupActions() {
        valueTextField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
    }
    
    private func setupBindings() {
        viewModel.$isValidValue
            .receive(on: RunLoop.main)
            .sink { [weak self] isValid in
                self?.continueButton.isEnabled = isValid
                self?.continueButton.backgroundColor = isValid ? UIColor(red: 130/255, green: 10/255, blue: 209/255, alpha: 1.0) : UIColor.systemGray.withAlphaComponent(0.5)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Keyboard Handling
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
            // Ajusta a constraint para ficar acima do teclado + 20 de margem
            continueButtonBottomConstraint?.constant = -(keyboardHeight + 20)
            
            // Anima a mudança junto com o teclado
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        // Volta para a posição original
        continueButtonBottomConstraint?.constant = -50
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Actions
    @objc private func didChangeText() {
        viewModel.valueString = valueTextField.text ?? ""
    }
    
    @objc private func didTapContinue() {
        viewModel.confirmValue()
    }
}
