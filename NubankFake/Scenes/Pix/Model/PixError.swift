//
//  PixError.swift
//  NubankFake
//
//  Created by Jota Pe on 11/11/25.
//

import Foundation

enum PixError: Error, LocalizedError {
    case invalidKey
    
    var errorDescription: String? {
        switch self {
        case .invalidKey:
            return "Chave inválida ou não encontrada."
        }
    }
}
