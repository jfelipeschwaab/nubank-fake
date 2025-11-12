//
//  PixValueViewModel.swift
//  NubankFake
//
//  Created by Jota Pe on 12/11/25.
//

import Foundation
import Combine

class PixValueViewModel {
    
    // --- Dados de Entrada ---
    let pixData: PixData
    
    // --- Callbacks de Navegação ---
    var onValueConfirmed: ((PixData, Double) -> Void)?
    
    // --- Estado para a View (Data Binding) ---
    // A View (UITextField) deve estar bindada a esta property
    @Published var valueString: String = "R$ 0,00"
    @Published var isValidValue: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(pixData: PixData) {
        self.pixData = pixData
        
        // Observa a string de valor para validar se é > 0
        $valueString
            .map { [weak self] strValue -> Double in
                return self?.parseDouble(from: strValue) ?? 0.0
            }
            .map { $0 > 0 } // Regra de negócio: só é válido se > 0
            .assign(to: \.isValidValue, on: self)
            .store(in: &cancellables)
    }
    
    /// Converte a string de moeda (ex: "R$ 10,50") para Double (10.50)
    private func parseDouble(from currencyString: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.number(from: currencyString)?.doubleValue ?? 0.0
    }
    
    /// Ação chamada pelo botão "Avançar" da View
    func confirmValue() {
        let value = parseDouble(from: valueString)
        if value > 0 {
            // Passa o PixData + o novo Valor para a próxima tela
            onValueConfirmed?(pixData, value)
        }
    }
}
