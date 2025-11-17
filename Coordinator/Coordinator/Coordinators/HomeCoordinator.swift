//
//  HomeCoordinator.swift
//  Coordinator
//
//  Created by Débora Cristina Silva Ferreira on 07/11/25.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    var parentCoordinator: (Coordinator)?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        showHome()
    }
    
    private func showHome() {
        let viewModel = HomeViewModel()
        viewModel.coordinator = self
        let homeViewController = HomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([homeViewController], animated: true)
    }
    
    
}
