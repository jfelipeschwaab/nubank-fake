//
//  OperadorViewModel.swift
//  NubankFake
//
//  Created by Keitiely Silva Viana on 12/11/25.
//

import Foundation

class RecargaOperadoraViewModel {
    
    //  O número que veio da tela anterior
    let numero: String
    
    // A operadora que o usuário vai escolher
    var operadoraSelecionada: Operadora?
    
    //callback avisando o coordinator
    var didSelectOperadora:((_ operadora: Operadora) -> Void)?
    
    // O ViewModel precisa do número para existir
    init(numero: String) {
        self.numero = numero
    }
    
    // A View vai chamar isso quando um botão for tocado
    func selecionarOperadora(operadora: Operadora) {
        // A lógica é só armazenar.
        self.operadoraSelecionada = operadora
        
        print("ViewModel: Operadora \(operadora.rawValue) selecionada!")
        didSelectOperadora?(operadora)//avisei o coordinator para ir para proxima tela
    }
}
