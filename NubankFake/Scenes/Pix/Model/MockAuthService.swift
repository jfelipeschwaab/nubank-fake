//
//  MockAuthService.swift
//  NubankFake
//
//  Created by Jota Pe on 12/11/25.
//

import Foundation

class MockAuthService: AuthServiceProtocol {
    
    private let MOCKED_PASSWORD = "1234" /// senha mockada teste
    
    func authenticate(password: String) async -> Bool {
        // Simula um delay de rede de 0.5 segundos
        try? await Task.sleep(nanoseconds: 500_000_000)
        return password == MOCKED_PASSWORD
    }
}
