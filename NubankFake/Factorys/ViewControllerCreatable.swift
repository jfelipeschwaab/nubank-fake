//
//  BuilderViewController.swift
//  NubankFake
//
//  Created by Débora Cristina Silva Ferreira on 11/11/25.
//

import Foundation
import UIKit

protocol ViewControllerCreatable {
    associatedtype CoordinatorType
    func make(coordinator: CoordinatorType) -> UIViewController
}
