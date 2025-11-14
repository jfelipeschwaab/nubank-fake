//
//  PixConfirmationViewModel.swift
//  NubankFake
//
//  Created by Jota Pe on 12/11/25.
//

import Foundation

class PixConfirmationViewModel {
    
    // --- Dados de Entrada ---
    let pixData: PixData
    let value: Double
    
    // --- Callbacks de Navegação ---
    var onFinalConfirmation: ((PixData, Double) -> Void)?
    
    // --- Estado para a View (Propriedades Formatadas) ---
    var recipientName: String { pixData.recipientName }
    var recipientCPF: String { pixData.recipientCPF }
    var recipientBank: String { pixData.recipientBank }
    
    /// Formata o valor Double para a string de moeda (ex: "R$ 10,50")
    var valueString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
    }
    
    init(pixData: PixData, value: Double) {
        self.pixData = pixData
        self.value = value
    }
    
    /// Ação chamada pelo botão "Confirmar Pagamento" da View
    func confirmTransfer() {
        // Passa os dados para a próxima tela (a de Senha)
        onFinalConfirmation?(pixData, value)
    }
}
