//
//  HomeView.swift
//  NubankFake
//
//  Created by Débora Cristina Silva Ferreira on 11/11/25.
//

import Foundation
import UIKit

protocol HomeViewDelegate: AnyObject {
    func didTapRecharge()
//    func didTapPix()
}

class HomeView: UIView {
    weak var delegate: HomeViewDelegate?

    private let saudacao: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let saldoMensagem: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let buttonTransfer: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "dollarsign.arrow.trianglehead.counterclockwise.rotate.90"), for: .normal)
        button.backgroundColor = .purple
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 25
//        button.addTarget(nil, action: #selector(pixTapped), for: .touchUpInside)
        return button
    }()
    private let labelTransfer: UILabel = {
        let label = UILabel()
        label.text = "Pix"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let buttonRecharge: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "iphone.gen3"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        button.tintColor = .white
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 25
        button.addTarget(nil, action: #selector(rechargeTapped), for: .touchUpInside)

        return button
    }()
    
    private let labelRecharge: UILabel = {
        let label = UILabel()
        label.text = "Recarga"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .black
        
        addSubview(saudacao)
        addSubview(saldoMensagem)
        addSubview(buttonTransfer)
        addSubview(buttonRecharge)
        addSubview(labelRecharge)
        addSubview(labelTransfer)
        
        let buttonStack = UIStackView(arrangedSubviews: [buttonTransfer, buttonRecharge])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 30
        buttonStack.alignment = .center
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            saudacao.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            saudacao.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            saldoMensagem.topAnchor.constraint(equalTo: saudacao.bottomAnchor, constant: 12),
            saldoMensagem.leadingAnchor.constraint(equalTo: saudacao.leadingAnchor),
            
            buttonStack.topAnchor.constraint(equalTo: saldoMensagem.bottomAnchor, constant: 40),
            buttonStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            labelRecharge.topAnchor.constraint(equalTo: buttonRecharge.bottomAnchor, constant: 8),
            labelRecharge.centerXAnchor.constraint(equalTo: buttonRecharge.centerXAnchor),
            
            labelTransfer.topAnchor.constraint(equalTo: buttonTransfer.bottomAnchor, constant: 8),
            labelTransfer.centerXAnchor.constraint(equalTo: buttonTransfer.centerXAnchor)
    ])
    }
    
    func setupBinding(with data: HomeModel) {
        saudacao.text = "Olá, \(data.name)"
        saldoMensagem.text = "Saldo: R$ \(data.accountBalance)"
    }
    
//    @objc private func pixTapped() {
//        delegate?.didTapRecharge()
//    }
    @objc private func rechargeTapped() {
        delegate?.didTapRecharge()
    }
}

