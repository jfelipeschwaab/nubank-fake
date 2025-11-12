//
//  AuthService.swift
//  NubankFake
//
//  Created by Letícia Delmilio Soares on 12/11/25.
//

//autenticar senha da nunbank

import Foundation

class AuthService: AppAuthServiceProtocol {
    
    static let shared = AuthService()
    private init() {}
    
    // Dicionário para armazenar múltiplos usuários de teste (Senha como Chave)
    private let testUsers: [String: Account] = [
        "1234": Account(id: 1, nome: "Letícia Delmilio", accountBalance: 600), // Usuário 1
//        "9876": User(id: "2", nome: "João ", accountBalance: 5_000.00),         // Usuário 2
//        "2025": User(id: "3", nome: "Maria", accountBalance: 120_000.00)     // Usuário 3
    ]
    
    /**
     Simula a validação da senha.
     Retorna um objeto User se a senha estiver correta, ou nil caso contrário.
     */
    func validate(password: String) -> Account? {
        // Atraso de 1 segundo para imitar uma API
        Thread.sleep(forTimeInterval: 1.0)
        
        // VERIFICA se a senha existe como uma chave no dicionário
        // Se existir, retorna o objeto User associado a essa chave.
        return testUsers[password]
    }
}
