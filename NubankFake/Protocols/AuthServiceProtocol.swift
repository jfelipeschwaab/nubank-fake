//
//  AuthServiceProtocol.swift
//  NubankFake
//
//  Created by Jota Pe on 12/11/25.
//

import Foundation

protocol AuthServiceProtocol {
    /// Verifica se a senha mockada é válida.
    func authenticate(password: String) async -> Bool
}
