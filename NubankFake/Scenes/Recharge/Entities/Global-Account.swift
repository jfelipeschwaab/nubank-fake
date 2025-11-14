//
//  Global-Account.swift
//  NubankFake
//
//  Created by Keitiely Silva Viana on 12/11/25.
//

import Foundation

struct UserModel {
    var nome: String
    var saldoEmConta: Double
    var cartaoDeCredito: CardModel
}

struct CardModel {
    var ultimos4Digitos: String
}

// O repositório "fake" que guarda o usuário mocado
class MockDataStore {
    // A instância global
    static let shared = MockDataStore()
    
   var mockUser = UserModel(
        nome: "João Felipe",
        saldoEmConta: 30.00,
        cartaoDeCredito: CardModel(ultimos4Digitos: "1234")
    )
}

