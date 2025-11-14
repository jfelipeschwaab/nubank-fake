//
//  HomeBuilder.swift
//  NubankFake
//
//  Created by Débora Cristina Silva Ferreira on 11/11/25.
//

import Foundation
import UIKit

struct HomeViewControllerFactory: ViewControllerCreatable {
    func make(coordinator: HomeCoordinator) -> UIViewController {
        let viewModel = HomeViewModel(coordinator: coordinator)
        let homeViewController = HomeViewController(viewModel: viewModel)
        return homeViewController
    }
}
