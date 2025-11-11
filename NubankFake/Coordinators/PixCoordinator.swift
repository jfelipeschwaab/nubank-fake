//
//  PixCoordinator.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

import Foundation
import UIKit



final class PixCoordinator : Coordinator {
    
    weak var parentCoordinator : Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
        
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
//        let pixViewModel = nil //TODO: Implementar pixViewModel
        let pixViewController = PixViewController()
        //pixViewModel.coordinator = self
        //TODO: Quem deve ter a referência do coordinator será a viewModel, está sendo atribuido à View por motivos de teste
        pixViewController.coordinator = self
        navigationController.pushViewController(pixViewController, animated: true)
    }
    
    func showPixKeyScreen() {
        let pixKeyViewController = PixKeyViewController()
        navigationController.pushViewController(pixKeyViewController, animated: true)
    }
}


