//
//  HomeService.swift
//  NubankFake
//
//  Created by Débora Cristina Silva Ferreira on 12/11/25.
//

import Foundation

protocol HomeServiceProtocol {
    func getHomeData(completion: @escaping (HomeModel) -> Void)
}

class HomeService: HomeServiceProtocol {
    func getHomeData(completion: @escaping (HomeModel) -> Void) {
        let account = MockData.joaoAccount
        
        let homeData = HomeModel(name: account.userName, accountBalance: account.accountBalance)
        completion(homeData)
    }
}
