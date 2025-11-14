//
//  PixError.swift
//  NubankFake
//
//  Created by Jota Pe on 11/11/25.
//

import Foundation

enum PixError: Error, LocalizedError {
    case invalidKey
    case invalidPassword
    case fundsNotEnough
    var errorDescription: String? {
        switch self {
        case .invalidKey:
            return "Chave inválida ou não encontrada. Tente novamente."
        case .invalidPassword:
            return "Senha inválida. Tente novamente."
        case .fundsNotEnough:
            return "Saldo insuficiente."
        }
    }
}
