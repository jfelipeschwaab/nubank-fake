//
//  PixValueViewModel.swift
//  NubankFake
//
//  Created by Jota Pe on 12/11/25.
//

import Foundation
import Combine

class PixValueViewModel {
    
    private let builder: BuilderPixTransaction
    private weak var coordinator: PixCoordinator?
    
    @Published var valueString: String = "0,00"
    @Published var isValidValue: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    // O init agora recebe o Builder e o Coordinator, mantendo o padrão das telas anteriores
    init(builder: BuilderPixTransaction, coordinator: PixCoordinator) {
        self.builder = builder
        self.coordinator = coordinator
        
        setupBindings()
    }
    
    private func setupBindings() {
        // Observa a string de valor para validar se é > 0
        $valueString
            .map { [weak self] strValue -> Double in
                return self?.parseDouble(from: strValue) ?? 0.0
            }
            .map { $0 > 0 } // Regra de negócio: só é válido se > 0
            .assign(to: \.isValidValue, on: self)
            .store(in: &cancellables)
    }
    
    /// Converte a string (ex: "10,50") para Double (10.50)
    private func parseDouble(from currencyString: String) -> Double {
        let cleanString = currencyString
            .replacingOccurrences(of: "R$", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: ".", with: ",")
        
        return Double(cleanString) ?? 0.0
    }
    
    /// Ação chamada pelo botão "Avançar" da View
    func confirmValue() {
        let value = parseDouble(from: valueString)
        
        if value > 0 {
            builder.setValue(value)
            coordinator?.showSecondPixConfirmationScreen(valueToConfirm: value)
        }
    }
}
