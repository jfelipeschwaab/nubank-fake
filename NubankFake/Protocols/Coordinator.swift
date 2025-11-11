//
//  Coordinator.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//
import UIKit

protocol Coordinator : AnyObject {
    var parentCoordinator: Coordinator? {get set}
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController { get set }
    func childDidFinish(_ child: Coordinator?)
    func start()
}

extension Coordinator {
    func childDidFinish(_ child: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)
        }
    }
}
