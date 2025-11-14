//
//  PixRecipientViewModel.swift
//  NubankFake
//
//  Created by Jota Pe on 12/11/25.
//

import Foundation

class PixRecipientViewModel {
    
    // --- Dados de Entrada ---
    let pixData: PixData
    
    // --- Callbacks de Navegação ---
    var onRecipientConfirmed: ((PixData) -> Void)?
    
    // --- Estado para a View (Propriedades Formatadas) ---
    // A View apenas lê essas propriedades
    var recipientName: String { pixData.recipientName }
    var recipientCPF: String { pixData.recipientCPF }
    var recipientBank: String { pixData.recipientBank }
    var recipientCity: String { pixData.cidade }
    
    init(pixData: PixData) {
        self.pixData = pixData
    }
    
    /// Ação chamada pelo botão "Transferir" da View
    func confirmRecipient() {
        // Passa o mesmo PixData para a próxima tela (a de Valor)
        onRecipientConfirmed?(pixData)
    }
}
