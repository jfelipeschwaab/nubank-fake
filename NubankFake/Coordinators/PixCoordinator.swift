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
//        let pixViewModel = nil //TODO: Implementar ViewModel na View
        let pixViewController = PixViewController()
        //pixViewModel.coordinator = self
        //TODO: Quem deve ter a referência do coordinator será a viewModel, está sendo atribuido à View por motivos de teste
        pixViewController.coordinator = self
        navigationController.pushViewController(pixViewController, animated: true)
    }
    
    func showPixKeyScreen() {
        //TODO: Implementar ViewModel na View
        let pixKeyViewController = PixKeyViewController()
        pixKeyViewController.coordinator = self
        navigationController.pushViewController(pixKeyViewController, animated: true)
    }
    
    func showPixConfirmationScreen() {
        //TODO: Implementar ViewModel na View
        let pixConfirmationViewController = PixConfirmationViewController()
        pixConfirmationViewController.coordinator = self
        navigationController.pushViewController(pixConfirmationViewController, animated: true)
    }
    
    func showPixValueScreen() {
        //TODO: Implementar ViewModel na View
        let pixValueViewController = PixValueViewController()
        pixValueViewController.coordinator = self
        navigationController.pushViewController(pixValueViewController, animated: true)
    }
    
    func showSecondPixConfirmationScreen(valueToConfirm : Double) {
        //TODO: Implementar ViewModel na View
        let pixConfirmationViewController = PixConfirmationViewController(hasValue: true, value: valueToConfirm)
        
        navigationController.pushViewController(pixConfirmationViewController, animated: true)
    }
}


