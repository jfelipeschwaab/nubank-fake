//
//  OnBoardingViewModel.swift
//  Coordinator
//
//  Created by Débora Cristina Silva Ferreira on 07/11/25.
//

import Foundation

class OnboardingViewModel {
    weak var coordinator: OnboardingCoordinator?
    
    func goToLogin() {
        coordinator?.showLogin()
    }
}
