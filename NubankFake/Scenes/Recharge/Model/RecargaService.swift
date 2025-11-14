//
//  File.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

import Foundation

// O ViewModel só vai conhecer isso
protocol RecargaServiceProtocol {
    func validarNumero(_ numero: String, completion: @escaping (Bool) -> Void)
}

//Implementação "Fake" (Mock)
class RecargaServiceMock: RecargaServiceProtocol {
    func validarNumero(_ numero: String, completion: @escaping (Bool) -> Void) {
        print("Serviço: Validando o número \(numero)...")
        
        // Simula uma demora de rede de 1 segundo
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // regra de 11 dígitos
            let ehValido = numero.count >= 11
            print("Serviço: Número é válido? \(ehValido)")
            completion(ehValido)
        }
    }
}
