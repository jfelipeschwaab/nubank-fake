//
//  PaymentError.swift
//  NubankFake
//
//  Created by Jota Pe on 12/11/25.
//

import Foundation

enum PaymentError : Error, LocalizedError {
    case insufficientFunds
    case genericError
    
    var errorDescription: String? {
        switch self {
        case .insufficientFunds:
            return "Saldo insuficiente."
        case .genericError:
            return "Erro ao processar o pagamento. Tente novamente."
        }
    }
}

protocol PaymentServiceProtocol {
    ///Executa o pagamento discontando do saldo 
    func makePayment(amount: Double, to recipient: PixData) async -> Result<Void, PaymentError>
}
