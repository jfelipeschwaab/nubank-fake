//
//  PixRecipientViewModel.swift
//  NubankFake
//
//  Created by Jota Pe on 12/11/25.
//

import Foundation
import Combine

class PixRecipientViewModel {

    private let builder: BuilderPixTransaction
    weak var coordinator: PixCoordinator?
    
    @Published var recipientName: String
    @Published var recipientCPF: String
    @Published var recipientBank: String
    @Published var cidade: String
    
    init(builder: BuilderPixTransaction, coordinator: PixCoordinator) {
        self.builder = builder
        self.coordinator = coordinator
        
        self.recipientName = builder.recipientName ?? "Nome não encontrado"
        self.cidade = builder.cidade ?? "Cidade não encontrada"
        self.recipientCPF = builder.recipientCPF ?? "***.***.***-**"
        self.recipientBank = builder.recipientBank ?? "Instituição não encontrada"
    }
    
    /// Ação chamada pelo botão "Confirmar" da View
    func didTapConfirm() {
        coordinator?.showPixValueScreen()
    }
    
    func didFinishTransaction() {
        coordinator?.didFinish()
    }
}
