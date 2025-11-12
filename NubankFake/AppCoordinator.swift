//
//  AppCoordinator.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

import Foundation
import UIKit


final class AppCoordinator : Coordinator {
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    private var window: UIWindow

    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        showHomeCoordinator()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    func showHomeCoordinator(){
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.parentCoordinator = self
        homeCoordinator.start()
        childCoordinators.append(homeCoordinator)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        guard let child = child else { return }
        if let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)
        }
    }
}
