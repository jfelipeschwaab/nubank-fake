//
//  MockPaymentService.swift
//  NubankFake
//
//  Created by Jota Pe on 12/11/25.
//

import Foundation

class MockPaymentService: PaymentServiceProtocol {
    
    // Saldo mockado inicial do usuário
    private var currentBalance: Double = 5000.00
    
    func makePayment(amount: Double, to recipient: PixData) async -> Result<Void, PaymentError> {
        // Simula um delay de rede de 1 segundo
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        if amount > currentBalance {
            return .failure(.insufficientFunds)
        }
        
        ///Debita o saldo (lógica de negócio)
        currentBalance -= amount
        
        print("--- Pagamento Realizado ---")
        print("Valor: R$\(amount)")
        print("Destinatário: \(recipient.recipientName)")
        print("Saldo Restante: R$\(currentBalance)")
        print("---------------------------")
        
        return .success(())
    }
}
