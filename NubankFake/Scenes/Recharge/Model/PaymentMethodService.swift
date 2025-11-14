//
//  PaymentMethodService.swift
//  NubankFake
//
//  Created by Keitiely Silva Viana on 12/11/25.
//

import Foundation

protocol PaymentMethodService {
    func FetchUserData(completion: @escaping (Result<Account, Error>) -> Void)
    func EfetuarRecarga(numero: String, operadora: Operadora, valor: Double, forma: FormaPagamento, completion: @escaping (Bool) -> Void)
    func ValidarValor(valor: Double, completion: @escaping (Bool) -> Void)
    
}

class PaymentMethodServiceMock: PaymentMethodService {
    
    func FetchUserData(completion: @escaping (Result<Account, Error>) -> Void) {
        print("Buscando os dados do usuario....no Mock")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let user = MockData .joaoAccount
            print("Dados encontrados:\(user.accountBalance)")
            
            completion(.success(user))
        }
 }
    func EfetuarRecarga(numero: String, operadora: Operadora, valor: Double, forma: FormaPagamento, completion: @escaping (Bool) -> Void) {
        print("Serviço payment: Recebido pedido de recarga de  \(valor)...")
        
    }
    
    func ValidarValor(valor: Double, completion: @escaping (Bool) -> Void){
        
        //  Puxa o saldo atual
        let saldoAtual = MockData.joaoAccount.accountBalance
        
        // regra de negócio
        if saldoAtual < valor {
            print("Serviço payment: rejeitado. Saldo (R$ \(saldoAtual)) é insuficiente.")
            completion(false) // Avisa que falhou
            return
        }
        
        // Se chegou aqui, Decrementa o saldo
        print("SERVIÇO (Payment): Saldo OK. Decrementando...")
        MockData.joaoAccount.accountBalance -= valor
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            print("SERVIÇO (Payment): Recarga APROVADA.")
            completion(true) // Avisa que deu sucesso
    }
        
    }
}
