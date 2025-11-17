//
//  LoginViewModel.swift
//  Coordinator
//
//  Created by Débora Cristina Silva Ferreira on 07/11/25.
//

import Foundation

class LoginViewModel {
    weak var coordinator: OnboardingCoordinator?
    
    func goToHome() {
        coordinator?.didFinishOnboarding()
    }
}
