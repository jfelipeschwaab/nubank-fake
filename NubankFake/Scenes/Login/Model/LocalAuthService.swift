//
//  AuthService.swift
//  NubankFake
//
//  Created by Letícia Delmilio Soares on 11/11/25.
//

import Foundation
import LocalAuthentication

//autenticação local

class LocalAuthService: LocalAuthServiceProtocol {
    func authenticate(reason: String, completion: @escaping (Result<Account, LAError>) -> Void) {
        let context = LAContext()
        var error: NSError?
    
        
        /**reason: texto mostrado na tela do Face ID / Touch ID (ex: “Autorize para acessar sua conta”).
         completion: closure que será chamada quando a autenticação terminar, retornando:
         .success(()) → se o usuário autenticou com sucesso
         .failure(LAError) → se houve falha ou cancelamento
         O @escaping indica que essa closure será chamada depois que a função acabar (porque a autenticação é assíncrona).*/
        
        /**LAContext: representa o contexto de autenticação:  é o objeto que pede ao sistema iOS para iniciar o Face ID, Touch ID ou Passcode.
         error: variável usada para capturar erros ao verificar se o dispositivo pode autenticar.
*/
        
        
        // Usa a política unificada para permitir Passcode se a Biometria falhar
        let policy: LAPolicy = .deviceOwnerAuthentication
         //Se fosse .deviceOwnerAuthenticationWithBiometrics, somente biometria seria aceita.
        
        if context.canEvaluatePolicy(policy, error: &error) {//testa se o dispositivo tem suporte pra biometria
            context.evaluatePolicy(policy,
                                   localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        let account = Account(id: 3, userName: "lolo", accountBalance: 100)
                        completion(.success((account)))
                    } else if let laError = authError as? LAError {
                        completion(.failure(laError))
                    } else {
                        // Tratar caso o erro seja nil ou não seja LAError (raro)
                        completion(.failure(LAError(.appCancel)))
                    }
                }
            }
        } else if let nsError = error {
            // Se canEvaluatePolicy falhar, converte e retorna
            completion(.failure(LAError(_nsError: nsError)))
        }
    }
}
