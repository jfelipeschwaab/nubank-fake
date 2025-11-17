//
//  OnBoardingView.swift
//  Coordinator
//
//  Created by Débora Cristina Silva Ferreira on 07/11/25.
//

import Foundation

import UIKit

protocol OnboardingViewDelegate: AnyObject {
    func didTapNext()
}

class OnboardingView: UIView {
    weak var delegate: OnboardingViewDelegate?
    
    private var textLabel: UILabel = {
        var label = UILabel()
        label.text = "Onboarding View"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private var nextButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(nextTapped), for: .touchUpInside)
        return button
    }()
    init(){
        super.init(frame: .zero)
        backgroundColor = .white
        setupView()
        setupContraints()
    }
    private func setupView(){
        addSubview(textLabel)
        addSubview(nextButton)
    }
    @objc private func nextTapped(){
        delegate?.didTapNext()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupContraints(){
        let textLabelContraints : [NSLayoutConstraint] = [
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        let nextButtonContraints : [NSLayoutConstraint] = [
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 40),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(textLabelContraints)
        NSLayoutConstraint.activate(nextButtonContraints)
    }
}
