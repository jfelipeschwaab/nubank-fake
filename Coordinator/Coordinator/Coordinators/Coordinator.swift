//
//  Coordinatir.swift
//  Coordinator
//
//  Created by Débora Cristina Silva Ferreira on 06/11/25.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] {get set}
    var navigationController : UINavigationController {get set}
    func childDidFinish(_ child: Coordinator?)
    func start()
}

extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        guard let child = child else { return }
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
