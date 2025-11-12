//  File.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.

import Foundation
import UIKit

class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    private let homeView = HomeView()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = homeView
        homeView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        viewModel.onDataLoaded = { [weak self] data in
            self?.homeView.setupBinding(with: data)
        }
        viewModel.loadHomeData()
    }
}

extension HomeViewController: HomeViewDelegate {
    
}
