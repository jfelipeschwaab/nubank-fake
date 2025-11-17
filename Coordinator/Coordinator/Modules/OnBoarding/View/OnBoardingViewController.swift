//
//  OnBoardingViewController.swift
//  Coordinator
//
//  Created by Débora Cristina Silva Ferreira on 07/11/25.
//

import Foundation
import UIKit

class OnboardingViewController: UIViewController {
    private let myView = OnboardingView()
    private let viewModel: OnboardingViewModel
    
    init(viewModel: OnboardingViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        view = myView
        myView.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
}

extension OnboardingViewController: OnboardingViewDelegate {
    func didTapNext() {
        viewModel.goToLogin()
    }
}
