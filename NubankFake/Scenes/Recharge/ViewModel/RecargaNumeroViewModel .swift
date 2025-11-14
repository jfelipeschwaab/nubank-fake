//
//  File.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

import Foundation


class RecargaNumeroViewModel {
    
    
    // A dependência que recebe e avisa
    private let service: RecargaServiceProtocol
    
    // Callbacks para o Coordinator saber quando mudar
    var didFinishInput: ((_ numero: String) -> Void)?
    var didEncounterError: ((_ erro: String) -> Void)?
    
    //guardar o numero
    var numeroDigitado: String = ""
    
    
    // O Init  recebe o serviço
    init(service: RecargaServiceProtocol) {
        self.service = service
    }
    
    
    //  função que o botão vai chamar
    func botaoProximoTocado() {
        
        service.validarNumero(numeroDigitado){ [weak self] ehValido in
            
            // Garante que o self ainda existe
            guard let self = self else { return }
            
            if ehValido {
                // Sucesso! Avisa o coordinato
                print("ViewModel: Número Valido. Avisando o Coordinator.")
                self.didFinishInput?(self.numeroDigitado)
            }
            else{
                //error avisa o coordinatos
                print("ViewModel: Numero invalido. Avisando o Coordinator")
                self.didEncounterError?("Número inválido")
            }
            
            
        }
        
    }
}
