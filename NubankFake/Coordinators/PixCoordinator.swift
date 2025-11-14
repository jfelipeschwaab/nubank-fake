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
    
    private var builder = BuilderPixTransaction()
        
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let pixViewController = PixViewController()
        pixViewController.coordinator = self
        navigationController.pushViewController(pixViewController, animated: true)
    }
    
    func showPixKeyScreen() {
        let pixService = PixService()
        let viewModel = PixKeyViewModel(pixService: pixService, builder: self.builder, coordinator: self)
        let pixKeyViewController = PixKeyViewController(viewModel: viewModel)
        navigationController.pushViewController(pixKeyViewController, animated: true)
    }
    
    func showPixConfirmationScreen() {
        let viewModel = PixRecipientViewModel(builder: self.builder, coordinator: self)
        let pixConfirmationViewController = PixConfirmationViewController(viewModel: viewModel)
        navigationController.pushViewController(pixConfirmationViewController, animated: true)
    }
    
    func showPixValueScreen() {
        let viewModel = PixValueViewModel(builder: self.builder, coordinator: self)
        let pixValueViewController = PixValueViewController(viewModel: viewModel)
        navigationController.pushViewController(pixValueViewController, animated: true)
    }
    
    func showSecondPixConfirmationScreen(valueToConfirm: Double) {
        let viewModel = PixRecipientViewModel(builder: self.builder, coordinator: self)
        let pixConfirmationViewController = PixConfirmationViewController(viewModel: viewModel,hasValue: true, value: valueToConfirm)
        navigationController.pushViewController(pixConfirmationViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
        self.navigationController.popToRootViewController(animated: true)
    }
}
