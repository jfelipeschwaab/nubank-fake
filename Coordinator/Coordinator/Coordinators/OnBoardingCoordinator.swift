//
//  OnBoardingCoordinator.swift
//  Coordinator
//
//  Created by Débora Cristina Silva Ferreira on 07/11/25.
//

import Foundation
import UIKit

class OnboardingCoordinator: Coordinator {
    var parentCoordinator: (Coordinator)?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    func start() {
        showOnboarding()
    }
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func showOnboarding() {
        let viewModel = OnboardingViewModel()
        viewModel.coordinator = self
        let onboardingViewController = OnboardingViewController(viewModel: viewModel)
        navigationController.pushViewController(onboardingViewController, animated: true)
    }
    
    func showLogin() {
        let viewModel = LoginViewModel()
        viewModel.coordinator = self
        let loginViewController = LoginViewController(viewModel: viewModel)
        navigationController.pushViewController(loginViewController, animated: false)
    }
    
    func backToLogin(){
        navigationController.popViewController(animated: false)
    }
    
    func didFinishOnboarding() {
        parentCoordinator?.childDidFinish(self)
        (parentCoordinator as? AppCoordinator)?.showHomeCoordinator()
    }
    
    
}
