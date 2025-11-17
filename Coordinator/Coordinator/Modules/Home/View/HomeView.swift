//
//  HomeView.swift
//  Coordinator
//
//  Created by Débora Cristina Silva Ferreira on 07/11/25.
//

import Foundation

import UIKit

protocol HomeViewDelegate: AnyObject {
    func didTapLogout()
}

class HomeView: UIView {
    weak var delegate: HomeViewDelegate?
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Bem-vindo à Home!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sair", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(logoutTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(label)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30)
        ])
    }
    
    @objc private func logoutTapped() {
        delegate?.didTapLogout()
    }
}
