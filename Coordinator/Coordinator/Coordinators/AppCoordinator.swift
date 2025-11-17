//
//  MainCoordinator.swift
//  Coordinator
//
//  Created by Débora Cristina Silva Ferreira on 06/11/25.
//
import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showOnboardingCoordinator()
    }

    func showOnboardingCoordinator(){
        let onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController)
        onboardingCoordinator.parentCoordinator = self
        onboardingCoordinator.start()
        childCoordinators.append(onboardingCoordinator)
    }
    
    func showHomeCoordinator(){
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.parentCoordinator = self
        homeCoordinator.start()
        childCoordinators.append(homeCoordinator)
    }
}
