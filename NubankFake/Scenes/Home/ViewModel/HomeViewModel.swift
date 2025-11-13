//
//  File.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

import Foundation
import UIKit

class HomeViewModel{
    weak var coordinator: HomeCoordinator?
    var onDataLoaded: ((HomeModel) -> Void)?

    private let service = HomeService()
    var homeData: HomeModel?
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func loadHomeData(){
        service.getHomeData { [weak self] data in
            self?.homeData = data
            self?.onDataLoaded?(data)
        }
    }
    
//    func goToPix() {
//        coordinator?.showPix()
//
//    }
}
