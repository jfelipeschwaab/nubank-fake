//
//  HomeViewController.swift
//  Coordinator
//
//  Created by Débora Cristina Silva Ferreira on 07/11/25.
//

import UIKit

class HomeViewController: UIViewController {
    private let myView = HomeView()
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = myView
        myView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTapLogout() {
    }
}
