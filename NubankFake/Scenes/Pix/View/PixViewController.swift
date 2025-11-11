//
//  PixViewController.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//


import UIKit
final class PixViewController: UIViewController {

    weak var coordinator: PixCoordinator?

    private let startTransferButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Iniciar transferência", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.95)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Área Pix"
        setupView()
        setupLayout()
        startTransferButton.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(startTransferButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            startTransferButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startTransferButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startTransferButton.heightAnchor.constraint(equalToConstant: 48),
            startTransferButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            view.trailingAnchor.constraint(greaterThanOrEqualTo: startTransferButton.trailingAnchor, constant: 24)
        ])
    }

    @objc private func didTapStart() {
        coordinator?.showPixKeyScreen()
    }
}
