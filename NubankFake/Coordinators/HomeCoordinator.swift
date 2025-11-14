//
//  HomeViewCoordinator.swift
//  NubankFake
//
//  Created by Débora Cristina Silva Ferreira on 11/11/25.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    var factory = HomeViewControllerFactory()
    var parentCoordinator: (Coordinator)?
        
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHome()
    }
    
    private func showHome(){
        navigationController.setViewControllers([factory.make(coordinator: self)], animated: true)
    }
    
    func showPix() {
        let pixCoordinator = PixCoordinator(navigationController: navigationController)
        pixCoordinator.parentCoordinator = self
        pixCoordinator.start()
        childCoordinators.append(pixCoordinator)
    }
    
    func showRecharge() {
                let rechargeCoordinator = RecargaCoordinator(navigationController: navigationController)
                rechargeCoordinator.parentCoordinator = self
                rechargeCoordinator.start()
                childCoordinators.append(rechargeCoordinator)
            }
}
