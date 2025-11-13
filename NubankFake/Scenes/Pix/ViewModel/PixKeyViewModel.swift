//
//  File.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

import Foundation
import Combine

class PixKeyViewModel {
    
    private let pixService: PixServiceProtocol
    private let builder: BuilderPixTransaction
    weak var coordinator: PixCoordinator?
    
    @Published var key: String = " "
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init(pixService: PixServiceProtocol, builder: BuilderPixTransaction, coordinator: PixCoordinator) {
        self.pixService = pixService
        self.builder = builder
        self.coordinator = coordinator
    }
    
    ///Ação chamada pelo botão Avançar da View
    @MainActor
    func validateKey() {
        isLoading = true
        errorMessage = nil
        
        Task {
            let result = await pixService.fetchPixDetails(forKey: key)
            isLoading = false
            
            switch result {
            case .success(let pixData):
                print("DEU SUCESSO")
                builder
                    .setPixKey(key)
                    .setRecipientName(pixData.recipientName)
                    .setCidade(pixData.cidade)
                    .setRecipientBank(pixData.recipientBank)
                    .setRecipientCpf(pixData.recipientCPF)
                print("BUILDER SENDO POPULADO")
                
                coordinator?.showPixConfirmationScreen()
                
            case .failure(_):
                let message = "Chave pix inválida. Tente novamente"
                errorMessage = message
                
            }
        }
    }
}
